import AemiSDR
import SwiftUI

struct MainScreen: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(BlockerState.self) private var blockerState

    @State private var logoHeight = Self.initialViewHeight
    @State private var scrollOffset = 0.0

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                logoHeader
                scrollView
            }
            .transition(.blurReplace.combined(with: .opacity).combined(with: .scale))
            .animation(.smooth, value: scrollOffset)
            .animation(.smooth, value: logoHeight)
            .animation(.smooth, value: isEnabled)
            .fancyBlur()
        }
    }
}

private extension MainScreen {
    static var initialViewHeight: CGFloat {
        #if os(iOS)
        UIScreen.activeScreen?.bounds.height ?? 0.0
        #elseif os(macOS)
        NSApplication.shared.windows.first?.frame.height ?? 0.0
        #endif
    }
}

private extension MainScreen {
    var isEnabled: Bool {
        blockerState.state.boolean
    }

    var stateColor: Color {
        blockerState.state.color
    }

    var nadColor: Color {
        colorScheme == .dark ? .background : stateColor
    }

    var shadowColor: Color {
        colorScheme == .dark ? stateColor : stateColor.opacity(0.5)
    }

    private var logoHeader: some View {
        NadLogoHeaderView(
            mainColor: nadColor,
            shadowColor: shadowColor,
            colorScheme: colorScheme
        )
        .onGeometryChange(
            for: CGFloat.self,
            of: { $0.size.height },
            action: { if logoHeight != $0 { logoHeight = $0 } }
        )
        .blur(radius: blurRadius)
        .scaleEffect(scaleFactor, anchor: .top)
    }

    private var blurRadius: CGFloat {
        min(abs(min(scrollOffset, 0)) / 10, 64)
    }

    private var scaleFactor: CGFloat {
        1 + (min(max(scrollOffset, 0) / 10, 61.8) / 100)
    }
}

private extension MainScreen {
    private var scrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                HeroView()
                    .padding(.top, 64)

                InformationView()

                divider

                CreditsView()
            }
            .padding(.top, logoHeight)
            .padding(.horizontal)
            .onGeometryChange(
                for: CGFloat.self,
                of: { $0.frame(in: .named("ScrollView")).origin.y },
                action: { if scrollOffset != $0 { scrollOffset = $0 } }
            )
        }
        .scrollClipDisabled()
        .coordinateSpace(name: "ScrollView")
        .frame(maxWidth: 600)
    }

    private var divider: some View {
        Divider()
            .frame(width: 64)
            .padding(.top, 48)
            .padding(.bottom, 26)
    }
}

private extension View {
    func fancyBlur() -> some View {
        #if os(iOS)
        roundedRectMask(fadeWidth: 14)
            .roundedRectBlur(fadeWidth: 14)
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .verticalEdgeMask(height: proxy.safeAreaInsets.top + 32, edges: .top)
                        .verticalEdgeMask(height: proxy.safeAreaInsets.bottom + 32, edges: .bottom)
                        .verticalEdgeBlur(height: proxy.safeAreaInsets.top + 32, maxBlurRadius: 10, edges: .top)
                        .verticalEdgeBlur(height: proxy.safeAreaInsets.bottom + 32, edges: .bottom)
                }
            }
        #else
        mask {
            maskContent
        }
        #endif
    }

    private var maskContent: some View {
        VStack(spacing: 0) {
            LinearGradient(
                colors: [.clear, .black.opacity(0.3), .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 64)
            Color.black
            LinearGradient(
                colors: [.clear, .black],
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    MainScreen()
        .environment(BlockerState())
}
