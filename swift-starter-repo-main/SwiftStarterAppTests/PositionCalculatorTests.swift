import XCTest
@testable import SwiftStarterApp

final class PositionCalculatorTests: XCTestCase {
    var positionCalculator: PositionCalculator!
    let stepLength: Double = 0.75
    
    override func setUp() {
        super.setUp()
        positionCalculator = PositionCalculator()
    }
    
    override func tearDown() {
        positionCalculator = nil
        super.tearDown()
    }
    
    func testPositionCalculation() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 0, y: 0)
        
        let position1 = calculator.calculateNewPosition(currentPosition: initialPosition, steps: 10, heading: 0)
        XCTAssertEqual(position1.x, 7.5, accuracy: 0.01)
        XCTAssertEqual(position1.y, 0.0, accuracy: 0.01)
        
        let position2 = calculator.calculateNewPosition(currentPosition: initialPosition, steps: 10, heading: 90)
        XCTAssertEqual(position2.x, 0.0, accuracy: 0.01)
        XCTAssertEqual(position2.y, 7.5, accuracy: 0.01)
    }
    
    
    func testMovementAtHeading0() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 0.0, y: 0.0)
        let steps = 10
        let heading = 0.0
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        XCTAssertEqual(newPosition.x, initialPosition.x + Double(steps) * stepLength, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, initialPosition.y, accuracy: 0.0001)
    }
    
    func testMovementAtHeading90() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 0.0, y: 0.0)
        let steps = 10
        let heading = 90.0 // Moving East
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        XCTAssertEqual(newPosition.x, initialPosition.x, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, initialPosition.y + Double(steps) * stepLength, accuracy: 0.0001)
    }
    
    func testMovementAtHeading225() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 0.0, y: 0.0)
        let steps = 10
        let heading = 225.0 // Moving Southwest
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        let distance = Double(steps) * stepLength
        let expectedDeltaX = distance * cos(225.0 * .pi / 180)
        let expectedDeltaY = distance * sin(225.0 * .pi / 180)
        
        XCTAssertEqual(newPosition.x, initialPosition.x + expectedDeltaX, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, initialPosition.y + expectedDeltaY, accuracy: 0.0001)
    }
    
    func testNoMovement() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 10.0, y: 15.0)
        let steps = 0
        let heading = 45.0
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        XCTAssertEqual(newPosition.x, initialPosition.x, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, initialPosition.y, accuracy: 0.0001)
    }
    
    func testHeading360() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 0.0, y: 0.0)
        let steps = 10
        let heading = 360.0 // Equivalent to 0°
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        XCTAssertEqual(newPosition.x, Double(steps) * stepLength, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, 0.0, accuracy: 0.0001)
    }
    
    func testHeadingNegative360() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 0.0, y: 0.0)
        let steps = 10
        let heading = -360.0 // Equivalent to 0°
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        XCTAssertEqual(newPosition.x, Double(steps) * stepLength, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, 0.0, accuracy: 0.0001)
    }
    
    func testNegativeSteps() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 5.0, y: 5.0)
        let steps = -10 // Moving backward
        let heading = 90.0 // Moving East
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        XCTAssertEqual(newPosition.x, initialPosition.x, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, initialPosition.y - abs(Double(steps) * stepLength), accuracy: 0.0001)
    }
    
    func testHeadingGreaterThan360() {
        let calculator = PositionCalculator()
        let initialPosition = Position(x: 0.0, y: 0.0)
        let steps = 10
        let heading = 450.0 // Equivalent to 90° (450 - 360)
        
        let newPosition = calculator.calculateNewPosition(currentPosition: initialPosition, steps: steps, heading: heading)
        
        XCTAssertEqual(newPosition.x, 0.0, accuracy: 0.0001)
        XCTAssertEqual(newPosition.y, Double(steps) * stepLength, accuracy: 0.0001)
    }
}
