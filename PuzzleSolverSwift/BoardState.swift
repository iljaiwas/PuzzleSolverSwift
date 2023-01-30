//
//  BoardState.swift
//  PuzzleSolverSwift
//
//  Created by ilja on 29.01.2023.
//

import Foundation

struct BoardState : Equatable, Hashable {
    let pieces: Set<Piece>
    let size: Size

    func pieceFitsBoardBounds (_ piece: Piece) -> Bool {
        if piece.pos.x < 0 {
            return false
        }
        if piece.maxX > size.width - 1{
            return false
        }
        if piece.pos.y < 0 {
            return false
        }
        if piece.maxY > size.height - 1 {
            return false
        }
        return true
    }

    func moveIsValid (piece: Piece, direction: Direction) -> Bool {
        let movedPiece = piece.pieceByMovingIntoDirection(direction)

        if !pieceFitsBoardBounds(movedPiece) {
            return false
        }
        for staticPiece in pieces {
            if staticPiece.name == movedPiece.name {
                continue
            }
            if staticPiece.intersectsWithPiece(movedPiece) {
                return false
            }
        }
        return true
    }

    func boardStateAfterMove (piece: Piece, direction: Direction) -> BoardState {
        var newPieces = pieces
        newPieces.remove(piece)
        let movedPiece = piece.pieceByMovingIntoDirection(direction)
        newPieces.insert(movedPiece)
        return BoardState(pieces: newPieces, size: size)
    }

    func pieceWithName(_ name: String) -> Piece? {
        return pieces.first {$0.name == name }
    }

    func movablePieces() -> Set<Piece> {
        return pieces.filter { return pieceIsMoveable($0) }
    }

    func pieceIsMoveable(_ piece: Piece) -> Bool {
        for direcction in [Direction.up, Direction.down, Direction.left, Direction.right] {
            if moveIsValid(piece: piece, direction: direcction) {
                return true;
            }
        }
        return false
    }


}
