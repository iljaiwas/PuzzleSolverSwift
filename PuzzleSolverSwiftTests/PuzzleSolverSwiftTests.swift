//
//  PuzzleSolverSwiftTests.swift
//  PuzzleSolverSwiftTests
//
//  Created by ilja on 29.01.2023.
//

import XCTest
@testable import PuzzleSolverSwift

class PuzzleSolverSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIntersectsWithPiece() {
        let pieceA = Piece (name: "A", pos: Point (x: 0, y: 0 ), size: Size (width: 2, height: 1))

        let pieceB = Piece (name: "B", pos: Point (x: 0, y: 0 ), size: Size (width: 2, height: 1))
        XCTAssertTrue(pieceA.intersectsWithPiece(pieceB))

        let pieceC = Piece (name: "C", pos: Point (x: 1, y: 0 ), size: Size (width: 2, height: 1))
        XCTAssertTrue(pieceA.intersectsWithPiece(pieceC))

        let pieceD = Piece (name: "D", pos: Point (x: 2, y: 0 ), size: Size (width: 2, height: 1))
        XCTAssertFalse(pieceA.intersectsWithPiece(pieceD))

        let b3 = Piece(name: "b3", pos: Point(x:1, y:4), size: Size (width: 1, height: 1))
        let y4 = Piece(name: "y4", pos: Point(x:0, y:3), size: Size (width: 1, height: 2))

        XCTAssertFalse(b3.intersectsWithPiece(y4))
        XCTAssertFalse(y4.intersectsWithPiece(b3))

    }

    func testPieceFitsBoardBounds ()
    {
        let board = BoardState (pieces: Set<Piece>(), size: Size (width: 2, height: 2))

        let pieceA = Piece (name: "A", pos: Point (x: 0, y: 0 ), size: Size (width: 2, height: 1))
        XCTAssertTrue(board.pieceFitsBoardBounds(pieceA))

        let pieceB = Piece (name: "B", pos: Point (x: 0, y: 0 ), size: Size (width: 2, height: 2))
        XCTAssertTrue(board.pieceFitsBoardBounds(pieceB))

        let pieceC = Piece (name: "C", pos: Point (x: 0, y: 0 ), size: Size (width: 3, height: 1))
        XCTAssertFalse(board.pieceFitsBoardBounds(pieceC))

        let pieceD = Piece (name: "D", pos: Point (x: 2, y: 0 ), size: Size (width: 1, height: 1))
        XCTAssertFalse(board.pieceFitsBoardBounds(pieceD))
    }

    func testIntitialState ()
    {
        let state = Solver.buildInitialBoard()
        let b3 = state.pieceWithName("b3")

        XCTAssertFalse(state.moveIsValid(piece: b3!, direction: .left))

        let movablePieces = state.movablePieces()
        XCTAssertEqual(movablePieces.count, 2)

        XCTAssertTrue (movablePieces.contains {$0 == state.pieceWithName("y1") })
        XCTAssertTrue (movablePieces.contains {$0 == state.pieceWithName("y3") })
        XCTAssertFalse (movablePieces.contains {$0 == state.pieceWithName("r1") })
    }

    func testMinimalInitialState()
    {
        var pieces = Set<Piece>()
        let solver = Solver(maxDepth: 30, outputEnabled: true)

        let r1 = Piece(name: "r1", pos: Point(x:1, y:0), size: Size (width: 2, height: 2))
        pieces.insert(r1)

        solver.solve(initialBoardState: BoardState (pieces: pieces, size: Size(width: 4, height: 5)))
    }

    func testMinimalInitialState2()
    {
        var pieces = Set<Piece>()
        let solver = Solver(maxDepth: 30, outputEnabled: true)

        let r1 = Piece(name: "r1", pos: Point(x:1, y:0), size: Size (width: 2, height: 2))
        pieces.insert(r1)

        let y2 = Piece(name: "y2", pos: Point(x:1, y:2), size: Size (width: 2, height: 1))
        pieces.insert(y2)

        solver.solve(initialBoardState: BoardState (pieces: pieces, size: Size(width: 4, height: 5)))
    }

    func testMinimalInitialState3()
    {
        var pieces = Set<Piece>()
        let solver = Solver(maxDepth: 30, outputEnabled: true)

        let r1 = Piece(name: "r1", pos: Point(x:1, y:0), size: Size (width: 2, height: 2))
        pieces.insert(r1)

        let y1 = Piece(name: "y1", pos: Point(x:0, y:1), size: Size (width: 1, height: 2))
        pieces.insert(y1)

        let y2 = Piece(name: "y2", pos: Point(x:1, y:2), size: Size (width: 2, height: 1))
        pieces.insert(y2)

        solver.solve(initialBoardState: BoardState (pieces: pieces, size: Size(width: 4, height: 5)))
    }
}
