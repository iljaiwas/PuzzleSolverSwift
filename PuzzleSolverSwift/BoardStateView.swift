//
//  BoardStateView.swift
//  PuzzleSolverSwift
//
//  Created by ilja on 30.01.2023.
//

import Cocoa

class BoardStateView: NSView {

    var boardSize = Size (width: 4, height: 5)

    override class func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.newBoardStateReceived(_:)), name: Notification.Name("NewBoardState"), object: nil)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    func drawGrid () {
        
    }

    @objc func newBoardStateReceived (_ notification: Notification) {

    }
    
}
