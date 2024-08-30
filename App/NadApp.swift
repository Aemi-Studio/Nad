import SwiftUI

@main
struct NadApp: App {

    @State
    private var blockerState = BlockerState()

    var body: some Scene {
        WindowGroup {
            MainScreen()
                #if os(macOS)
                .frame(minWidth: 375, minHeight: 604)
                .frame(maxWidth: 375, maxHeight: 604)
                .blurryBackground()
                #endif
                .environment(blockerState)
                .onChange(of: blockerState.isEnabled) { _, newValue in
                    if newValue {
                        Tools.setAlternateIconName("AppIcon2")
                    } else {
                        Tools.setAlternateIconName("AppIcon3")
                    }
                }
        }
        #if os(macOS)
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
