import Foundation
import CoreMotion
import CoreLocation
import Combine

protocol MotionServiceProtocol {
    func stepCountStream() -> AsyncStream<Int>
    func headingStream() -> AsyncStream<Double>
}

class MotionService: MotionServiceProtocol {
    @Published var stepCount: Int = 0
    @Published var heading: Double = 0.0
    
    private let pedometer = CMPedometer()
    private let motionManager = CMMotionManager()
    
    func stepCountStream() -> AsyncStream<Int> {
        AsyncStream { continuation in
            guard CMPedometer.isStepCountingAvailable() else {
                continuation.finish() // Graceful termination
                return
            }
            
            pedometer.startUpdates(from: Date()) { data, error in
                if let stepCount = data?.numberOfSteps.intValue, error == nil {
                    continuation.yield(stepCount)
                }
            }
            
            continuation.onTermination = { _ in
                self.pedometer.stopUpdates()
            }
        }
    }
    
    func headingStream() -> AsyncStream<Double> {
        AsyncStream { continuation in
            guard motionManager.isDeviceMotionAvailable else {
                continuation.finish() // Graceful termination
                return
            }
            
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if let heading = self.motionManager.deviceMotion?.heading {
                    continuation.yield(heading)
                }
            }
            
            continuation.onTermination = { _ in
                self.motionManager.stopDeviceMotionUpdates()
            }
        }
    }
}

class MockMotionService: MotionServiceProtocol {
    private var stepCount = 0
    private var heading = 0.0
    
    func stepCountStream() -> AsyncStream<Int> {
        stepCount = 0
        return AsyncStream { continuation in
            let timer = DispatchSource.makeTimerSource()
            timer.schedule(deadline: .now(), repeating: 2)
            timer.setEventHandler {
                self.stepCount += 10
                continuation.yield(self.stepCount)
            }
            timer.resume()
            
            continuation.onTermination = { _ in
                timer.cancel()
            }
        }
    }
    
    func headingStream() -> AsyncStream<Double> {
        heading = 0.0
        return AsyncStream { continuation in
            let timer = DispatchSource.makeTimerSource()
            timer.schedule(deadline: .now(), repeating: 2)
            timer.setEventHandler {
                self.heading = (self.heading + 15).truncatingRemainder(dividingBy: 360)
                continuation.yield(self.heading)
            }
            timer.resume()
            
            continuation.onTermination = { _ in
                timer.cancel()
            }
        }
    }
}
