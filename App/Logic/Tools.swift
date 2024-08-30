//
//  Tools.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation

#if os(macOS)
import Cocoa
#endif

struct Tools {

    #if os(iOS)
    static func openSettingsApplication() {
        UIApplication.shared.open(URL(string: "App-prefs:")!)
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
