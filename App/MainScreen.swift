import SwiftUI

struct MainScreen: View {

    @Environment(\.colorScheme)
    private var colorScheme

    @Environment(BlockerState.self)
    private var blockerState

    var isEnabled: Bool {
        blockerState.isEnabled
    }

    @State
    private var showMore: Bool = false

    private var enabledColor: Color {
        isEnabled ? .green : .red
    }

    private var nadColor: Color {
        colorScheme == .dark ? .background : enabledColor
    }

    private var shadowColor: Color {
        colorScheme == .dark ? enabledColor : enabledColor.opacity(0.2)
    }

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 32) {
                        ZStack {
                            Image("Nad.Curve")
                                .resizable()
                                .foregroundStyle(nadColor)
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 120)
                                .shadow(color: shadowColor, radius: 60)
                                .shadow(color: shadowColor, radius: 30)
                                .shadow(color: shadowColor, radius: 10)
                        }
                        .frame(height: 160)

                        VStack {
                            VStack(spacing: 12) {
                                Text("nad")
                                    .font(.largeTitle)
                                    .fontWidth(.expanded)
                                    .fontWeight(.black)
                                    .zIndex(100)

                                    VStack {
                                        Text(isEnabled ? "enabled" : "disabled")
                                            .font(.headline)
                                            .fontWidth(.expanded)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .multilineTextAlignment(.center)
                                            .textCase(.uppercase)
                                            .kerning(1)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 14)
                                    .background(enabledColor)
                                    .clipShape(.rect(cornerRadius: 8))
                                    .shadow(color: shadowColor.opacity(0.1), radius: 30)
                                    .shadow(color: shadowColor.opacity(0.2), radius: 15)
                                    .shadow(color: shadowColor.opacity(0.4), radius: 5)

                            }
                            if !isEnabled {
                                Group {
                                    Text("Enable Nad in ")
                                    + Text("Extensions settings of Safari")
                                        .foregroundStyle(.blue)
                                }
                                .onTapGesture {
                                    #if os(iOS)
                                    UIApplication.shared.open(URL(string: "App-prefs:SAFARI&path=CONTENT_BLOCKERS")!)
                                    #elseif os(macOS)
                                    let appleScriptSource = """
tell application "Safari"
    if it is not running then
        launch
    end if
    activate
end tell

tell application "Safari"
    activate
end tell

tell application "System Events"
    tell process "Safari"
        delay 1 -- Allow time for Safari to activate
        keystroke "," using {command down} -- Open Safari Preferences
        delay 1 -- Allow time for the Preferences window to appear
        click button "Extensions" of toolbar 1 of window 1 -- Click on the Extensions tab
    end tell
end tell
"""

                                    DispatchQueue.global(qos: .background).async {
                                        if let appleScript = NSAppleScript(source: appleScriptSource) {
                                            var error: NSDictionary?
                                            appleScript.executeAndReturnError(&error)

                                            if let error = error {
                                                print("AppleScript error: \(error)")
                                            }
                                        }
                                    }
                                    #endif
                                }
                                .padding()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 64)
                    .padding(.bottom, 48)

                    VStack(spacing: 10) {

                        InformationalButton(
                            title: NSLocalizedString("doweknowtrafic.title", comment: ""),
                            content: NSLocalizedString("doweknowtrafic.explanation", comment: "")
                        )

                        InformationalButton(
                            title: NSLocalizedString("dowesavedata.title", comment: ""),
                            content:  NSLocalizedString("dowesavedata.explanation", comment: "")
                        )

                        InformationalButton(
                            title: NSLocalizedString("howdoesitwork.title", comment: ""),
                            content: NSLocalizedString("howdoesitwork.explanation", comment: "")
                        )

                    }
                    .padding(10)
                    .zIndex(100)
                    .padding(.bottom, 48)

                    VStack {
                        CreditsView()
                    }
                    .padding()
#if os(iOS)
                    .padding(.bottom, 64)
                    #else
                    .padding(32)
                    #endif
                }
                .scrollIndicators(.never)
                .padding(0)
                #if os(iOS)
                .overlay(alignment: .top) {
                    VariableBlurView(direction: .blurredTopClearBottom)
                        .frame(maxHeight: 48)
                        .ignoresSafeArea(.all, edges: .top)
                }
                .overlay(alignment: .bottom) {
                    VariableBlurView(maxBlurRadius: 10, direction: .blurredBottomClearTop)
                        .frame(maxHeight: 32)
                        .ignoresSafeArea(.all, edges: .bottom)
                }
                .ignoresSafeArea(.all, edges: .bottom)
                #endif
            }
            .padding(0)
            .frame(maxWidth: 600)
        }

    }
}
