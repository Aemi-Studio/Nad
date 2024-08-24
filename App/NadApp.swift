import SwiftUI

@main
struct NadApp: App {

    @State
    private var blockerState = BlockerState()

    var body: some Scene {
        WindowGroup {
            MainScreen()
            #if os(macOS)
                .frame(idealWidth: 375, idealHeight: 640)
            #endif
                .environment(blockerState)
        }
        #if os(macOS)
        .windowResizability(.automatic)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
