//
//  Untitled.swift
//  Nad
//
//  Created by Guillaume Coquard on 22.09.25.
//

import OSLog

protocol Loggable {}

extension Loggable {
    static var logger: Logger {
        Logger(
            subsystem: Bundle.main.bundleIdentifier ?? "studio.aemi.Nad",
            category: String(describing: Self.self)
        )
    }
    
    var logger: Logger {
        Self.logger
    }
}
