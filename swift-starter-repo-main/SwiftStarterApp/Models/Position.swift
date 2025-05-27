import Foundation

struct Position {
    var x: Double = 0.0
    var y: Double = 0.0
}

class PositionCalculator {
    private let stepLength: Double = 0.75

    func calculateNewPosition(currentPosition: Position, steps: Int, heading: Double) -> Position {
        let headingRadians = heading * .pi / 180
        let distance = Double(steps) * stepLength

        let newX = currentPosition.x + distance * cos(headingRadians)
        let newY = currentPosition.y + distance * sin(headingRadians)

        return Position(x: newX, y: newY)
    }
}
