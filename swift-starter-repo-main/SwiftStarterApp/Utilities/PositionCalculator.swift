import Foundation

// This is a template for the PositionCalculator
// Candidates should implement this utility to calculate position based on steps and heading
// as per the assignment requirements

protocol PositionCalculatorProtocol {
    // Define methods for position calculation
    func calculateNewPosition(currentPosition: Position, steps: Int, heading: Double) -> Position
}

class PositionCalc: PositionCalculatorProtocol {
    // MARK: - Properties
    
    /// The length of a single step in meters
    let stepLength: Double = Constants.Motion.defaultStepLength
    
    // MARK: - Initialization
    
    // MARK: - Public Methods
    
    /// Calculates a new position based on the current position, steps taken, and heading direction
    /// - Parameters:
    ///   - currentPosition: The current (x,y) position
    ///   - steps: Number of steps taken
    ///   - heading: The heading in degrees (0-360)
    /// - Returns: The new position
    func calculateNewPosition(currentPosition: Position, steps: Int, heading: Double) -> Position {
        // TODO: Implement the position calculation using the formula:
        // x += stepLength * cos(headingRadians)
        // y += stepLength * sin(headingRadians)
        
        return currentPosition // Placeholder return
    }
    
    // MARK: - Private Methods
    
    /// Converts degrees to radians
    /// - Parameter degrees: The angle in degrees
    /// - Returns: The angle in radians
    private func degreesToRadians(_ degrees: Double) -> Double {
        // TODO: Implement degrees to radians conversion
        return 0.0 // Placeholder return
    }
} 
