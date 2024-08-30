import SwiftUI

struct MainScreen: View {

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {

                    HeroView()

                    InformationView()

                    Divider()
                        .frame(width: 64)
                        .padding(.top, 48)
                        .padding(.bottom, 26)

                    CreditsView()
                }
                .scrollViewConfiguration()

            }
            .padding(0)
            .frame(maxWidth: 600)
        }
    }
}

fileprivate extension View {

    func scrollViewConfiguration() -> some View {
        self
            .scrollIndicators(.never)
            .padding(0)
        #if os(iOS)
        .overlay(alignment: .top) {
        ZStack {
        VariableBlurView(direction: .blurredTopClearBottom)
        LinearGradient(
        colors: [
        Color.background,
        Color.background.opacity(0)
        ],
        startPoint: .top,
        endPoint: .bottom
        )
        }
        .frame(maxHeight: 50)
        .ignoresSafeArea(.all, edges: .top)
        }
        .overlay(alignment: .bottom) {
        ZStack {
        LinearGradient(
        colors: [
        Color.background,
        Color.background.opacity(0)
        ],
        startPoint: .bottom,
        endPoint: .top
        )
        }
        .frame(maxHeight: 48)
        .ignoresSafeArea(.all, edges: .bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        #endif
    }
}
