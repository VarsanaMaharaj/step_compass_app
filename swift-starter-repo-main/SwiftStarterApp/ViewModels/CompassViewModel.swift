import Foundation
import Combine
import SwiftUI

class CompassViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var stepCount: Int = 0
    @Published var heading: Double = 0.0
    @Published var position: Position = Position(x: 0.0, y: 0.0)
    
    // MARK: - Private Properties
    
    private let motionService: MotionServiceProtocol
    private let positionCalculator: PositionCalculator
    private var trackingTasks = [Task<Void, Never>]()
    private var isTracking = false
    
    // MARK: - Initialization
    
    init(
        motionService: MotionServiceProtocol = {
            #if targetEnvironment(simulator)
            return MockMotionService()
            #else
            return MotionService()
            #endif
        }(),
        positionCalculator: PositionCalculator = PositionCalculator()
    ) {
        self.motionService = motionService
        self.positionCalculator = positionCalculator
    }
    
    // MARK: - Public Methods
    
    // Starts tracking motion data
    func startTracking() {
        guard !isTracking else { return }
        isTracking = true
        
        // Step count task
        let stepTask = Task {
            do {
                for await steps in motionService.stepCountStream() {
                    await MainActor.run {
                        self.stepCount = steps
                        self.updatePosition()
                        print("Step count updated: \(steps)")
                    }
                }
            } catch {
                print("Step count stream error: \(error.localizedDescription)")
            }
        }
        trackingTasks.append(stepTask)
        
        // Heading task
        let headingTask = Task {
            do {
                for await heading in motionService.headingStream() {
                    await MainActor.run {
                        self.heading = heading
                        self.updatePosition()
                        print("Heading updated: \(heading)")
                    }
                }
            } catch {
                print("Heading stream error: \(error.localizedDescription)")
            }
        }
        trackingTasks.append(headingTask)
    }

    
    // Stops tracking motion data
    func stopTracking() {
        isTracking = false
        
        // Cancel all ongoing tasks
        trackingTasks.forEach { $0.cancel() }
        trackingTasks.removeAll()
    }
    
    // Resets the current position to the origin
    func resetPosition() {
        position = Position(x: 0.0, y: 0.0)
        stepCount = 0
        heading = 0.0
    }
    
    // MARK: - Private Methods
    
    // Updates the current position based on steps and heading
    private func updatePosition() {
        position = positionCalculator.calculateNewPosition(
            currentPosition: position,
            steps: stepCount,
            heading: heading
        )
    }
}
