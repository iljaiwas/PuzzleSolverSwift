//
//  AppDelegate.swift
//  PuzzleSolverSwift
//
//  Created by ilja on 29.01.2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            // Code only executes when not running tests
            NSLog("solver started")
            Solver(maxDepth: 40, outputEnabled: false).solve(initialBoardState: Solver.buildInitialBoard())
            NSLog("solver finished")
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

