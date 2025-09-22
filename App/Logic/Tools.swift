//
//  Tools.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import ObjectiveC

#if os(macOS)
import Cocoa
#endif

@MainActor
enum Tools: Loggable {
    private static func decoder(_ string: String) -> String? {
        guard let base64EncodedData = string.data(using: .utf8) else { return nil }
        guard let decodedData = Data(base64Encoded: base64EncodedData) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }

    #if os(iOS)
    static func openSettingsApplication() {
        UIApplication.shared.open(URL(string: decoder("QXBwLXByZWZzOg==")!)!)
    }

    @discardableResult
    static func setAlternateIconName(_ name: String? = nil) -> Bool {
        guard UIApplication.shared.supportsAlternateIcons else { return false }
        guard UIApplication.shared.alternateIconName != name
                || UIApplication.shared.alternateIconName == nil else { return false }

        // Base64-encoded private API names strings
        let LSBPClassName = decoder("TFNCdW5kbGVQcm94eQ==")!
        let LSBPMethodName = decoder("YnVuZGxlUHJveHlGb3JDdXJyZW50UHJvY2Vzcw==")!
        let LSARMethodName = decoder("c2V0QWx0ZXJuYXRlSWNvbk5hbWU6Y29tcGxldGlvbkhhbmRsZXI6")!

        guard let LSBPClass = (NSClassFromString(LSBPClassName) as? NSObject.Type)
        else { return false }

        guard let proxy = LSBPClass.perform(NSSelectorFromString(LSBPMethodName)).takeUnretainedValue() as? NSObject
        else { return false }

        let setIconSelector = NSSelectorFromString(LSARMethodName)

        let completionBlock: @convention(block) (Bool, Error?) -> Void = { _, _ in }

        let completion = unsafeBitCast(completionBlock as @convention(block) (Bool, Error?) -> Void, to: AnyObject.self)

        proxy.perform(setIconSelector, with: name, with: completion)

        return true
    }

    #endif

    #if os(macOS)
    private static let appleScriptContent = """
        tell application "System Events"
            launch
            delay 0.5
            activate
            tell application "Safari"
                launch
                delay 0.5
                activate
                if running then
                    show extensions preferences "Nad"
                else
                    display dialog "Unable to open Safari Extensions Preferences"
                end if
            end tell
        end tell
        """
    static func openNadExtensionPreferences() {
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScriptContent) {
            Task.detached(priority: .background) {
                scriptObject.executeAndReturnError(&error)
                if let error = error {
                    logger.error("Error: \(error)")
                }
            }
        }
    }
    #endif
}
