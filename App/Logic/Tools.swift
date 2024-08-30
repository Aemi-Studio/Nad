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

struct Tools {

    static private func decoder(_ string: String) -> String? {
        guard let base64EncodedData = string.data(using: .utf8) else { return nil }
        guard let decodedData = Data(base64Encoded: base64EncodedData) else { return nil }
        // swiftlint:disable:next non_optional_string_data_conversion
        return String(data: decodedData, encoding: .utf8)
    }

    #if os(iOS)
    static func openSettingsApplication() {
        UIApplication.shared.open(URL(string: decoder("QXBwLXByZWZzOg==")!)!)
    }

    static func setAlternateIconName(_ name: String? = nil) {

        guard  UIApplication.shared.alternateIconName != name else { return }

        let LSBPClassName = decoder("TFNCdW5kbGVQcm94eQ==")!
        let LSBPMethodName = decoder("YnVuZGxlUHJveHlGb3JDdXJyZW50UHJvY2Vzcw==")!
        let LSARMethodName = decoder("c2V0QWx0ZXJuYXRlSWNvbk5hbWU6Y29tcGxldGlvbkhhbmRsZXI6")!

        guard let LSBPClass = (NSClassFromString(LSBPClassName) as? NSObject.Type)
        else { return }

        guard let proxy =
                LSBPClass.perform(NSSelectorFromString(LSBPMethodName))
                .takeUnretainedValue() as? NSObject
        else { return }

        let setIconSelector = NSSelectorFromString(LSARMethodName)

        let completionBlock: @convention(block) (Bool, Error?) -> Void = { _, _ in }

        let completion = unsafeBitCast(completionBlock as @convention(block) (Bool, Error?) -> Void, to: AnyObject.self)

        proxy.perform(setIconSelector, with: name, with: completion)
    }

    #endif

    #if os(macOS)
    static func openNadExtensionPreferences() {
        let script = """
    tell application "System Events"
    launch
    activate
    tell application "Safari"
        launch
        activate
        if running then
            show extensions preferences "Nad"
        else
            display dialog "Unable to open Safari Extensions Preferences"
        end if
    end tell
    end tell
    """

        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            DispatchQueue.global(qos: .background).async {
                scriptObject.executeAndReturnError(&error)
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }
    }
    #endif

}
