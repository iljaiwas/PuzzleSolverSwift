//
//  Piece.swift
//  PuzzleSolverSwift
//
//  Created by ilja on 29.01.2023.
//

import Foundation

struct Point : Hashable {
    let x: Int
    let y: Int
}

struct Size: Hashable {
    let width: Int
    let height: Int
}

enum Direction {
case up
case down
case left
case right

    func oppositeDirection() -> Direction {
        switch(self) {
        case .up:
            return .down
        case .down:
            return .up
        case .right:
            return .left
        case .left:
            return .right
        }
    }
}

struct Piece: Hashable {
    let name: String
    let pos: Point
    let size: Size
    let occupiedPositions: Set<Point>

    init(name: String, pos: Point, size: Size ) {
        self.name = name
        self.pos = pos
        self.size = size
        self.occupiedPositions = Piece.computeOccupiedPositions (pos: pos, size: size)
    }

    var maxX: Int {
        return pos.x + size.width - 1
    }

    var maxY: Int {
        return pos.y + size.height - 1
    }

    static func computeOccupiedPositions(pos: Point, size: Size) -> Set<Point> {
        var result = Set<Point>()

        for x in pos.x...(pos.x + size.width - 1){
            for y in pos.y...(pos.y + size.height - 1) {
                result.insert(Point(x: x, y: y))
            }
        }
        return result
    }

    func pieceByMovingIntoDirection(_ direction: Direction) -> Piece {
        var newPos: Point
        switch (direction) {
        case .right:
            newPos = Point(x: pos.x + 1 , y: pos.y)
        case .left:
            newPos = Point(x: pos.x - 1 , y: pos.y)
        case .up:
            newPos = Point(x: pos.x  , y: pos.y + 1)
        case .down:
            newPos = Point(x: pos.x  , y: pos.y - 1)
        }

        return Piece(name: name, pos: newPos, size: size)
    }

    func intersectsWithPiece(_ otherPiece: Piece) -> Bool {
        return occupiedPositions.intersection(otherPiece.occupiedPositions).isEmpty == false
    }
}

