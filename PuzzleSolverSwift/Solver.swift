//
//  Solver.swift
//  PuzzleSolverSwift
//
//  Created by ilja on 29.01.2023.
//

import Foundation
import Algorithms

struct Move
{
    let pieceName: String
    let direction: Direction

    func printMove () {
        print ("Piece \(pieceName) -> \(direction)")
    }
}

struct Solver
{
    let maxDepth: Int
    let outputEnabled: Bool

    static func buildInitialBoard() -> BoardState {
        var pieces = Set<Piece>()

        let r1 = Piece(name: "r1", pos: Point(x:1, y:0), size: Size (width: 2, height: 2))
        pieces.insert(r1)

        let y1 = Piece(name: "y1", pos: Point(x:0, y:1), size: Size (width: 1, height: 2))
        pieces.insert(y1)

        let y2 = Piece(name: "y2", pos: Point(x:1, y:2), size: Size (width: 2, height: 1))
        pieces.insert(y2)

        let y3 = Piece(name: "y3", pos: Point(x:3, y:1), size: Size (width: 1, height: 2))
        pieces.insert(y3)

        let y4 = Piece(name: "y4", pos: Point(x:0, y:3), size: Size (width: 1, height: 2))
        pieces.insert(y4)

        let b1 = Piece(name: "b1", pos: Point(x:1, y:3), size: Size (width: 1, height: 1))
        pieces.insert(b1)

        let b2 = Piece(name: "b2", pos: Point(x:2, y:3), size: Size (width: 1, height: 1))
        pieces.insert(b2)

        let y5 = Piece(name: "y5", pos: Point(x:3, y:3), size: Size (width: 1, height: 2))
        pieces.insert(y5)

        let b3 = Piece(name: "b3", pos: Point(x:1, y:4), size: Size (width: 1, height: 1))
        pieces.insert(b3)

        let b4 = Piece(name: "b4", pos: Point(x:2, y:4), size: Size (width: 1, height: 1))
        pieces.insert(b4)

        return BoardState (pieces: pieces, size: Size(width: 4, height: 5))
    }

    func boardStateIsValidSolution (_ state: BoardState) -> Bool {

        return state.pieceWithName("r1")!.pos == Point(x: 1, y: 3)
    }

    func solve (initialBoardState: BoardState) {
        var checkedStates = Set<BoardState>()

        _ = solveBoardState (initialBoardState, stateStack: [BoardState](), moves: [Move](), checkedStates: &checkedStates, maxDepth: maxDepth)
    }

    func printStatus(_ string: String ) {
        if (outputEnabled) {
            print (string)
        }
    }

    func solveBoardState (_ state: BoardState, stateStack: [BoardState], moves: [Move], checkedStates: inout Set<BoardState>, maxDepth: Int) -> Bool{
        if (stateStack.count > maxDepth) {
            printStatus("Maximum stack depth reached -- backtracking")
            return false
        }

        for piecePermutation in state.movablePieces().uniquePermutations() {
            for piece in piecePermutation {
                for directionPermutation in [Direction.up, Direction.down, Direction.left, Direction.right].uniquePermutations() {
                    for direction in directionPermutation {
                        if (moves.last?.pieceName == piece.name && moves.last?.direction == direction.oppositeDirection()) {
                            // prevent direct undoing of previous move
                            continue
                        }
                        if state.moveIsValid(piece: piece, direction: direction) {
                            printStatus ("Depth \(stateStack.count), Move \(piece.name) -> \(direction)")
                            let newBoardState = state.boardStateAfterMove(piece: piece, direction: direction)
                            if stateStack.contains(where: {$0 == newBoardState }) {
                                printStatus("State already in stack -- backtracking")
                                return false
                            }
                            if checkedStates.contains(where: {$0 == newBoardState }) {
                                printStatus("State already checked -- backtracking")
                                return false
                            }
                            if boardStateIsValidSolution (newBoardState) {
                                print("Solution Found")
                                for move in moves {
                                    move.printMove()
                                }
                                return true
                            } else {
                                var newStates = stateStack
                                newStates.append(state)
                                var newMoves = moves
                                newMoves.append(Move (pieceName: piece.name, direction: direction))
                                if solveBoardState (newBoardState, stateStack: newStates, moves: newMoves, checkedStates: &checkedStates, maxDepth: maxDepth) {
                                    return true
                                }
                            }
                        }
                    }
                }
            }
        }
        // if we got here
        //checkedStates.insert (state)
        return false
    }
}
