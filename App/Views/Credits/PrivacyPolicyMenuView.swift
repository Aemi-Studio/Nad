//
//  PrivacyPolicyMenuView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import SwiftUI

struct PrivacyPolicyMenuView: View {
    private let aspppUrl = URL(string: "https://aemi.studio/privacy")!
    private let adepppUrl = URL(string: "https://aploi.de/privacy")!

    var body: some View {
#if os(iOS)
        iOSMenu
#else
        macOSMenu
#endif
    }
    
    @State private var isASPPPresented: Bool = false {
        didSet {
#if os(macOS)
            if isASPPPresented {
                NSWorkspace.shared.open(aspppUrl)
            }
#endif
        }
    }
    
    @State private var isADEPPPresented: Bool = false {
        didSet {
#if os(macOS)
            if isADEPPPresented {
                NSWorkspace.shared.open(adepppUrl)
            }
#endif
        }
    }
}

#if os(macOS)
private extension PrivacyPolicyMenuView {
    private var macOSMenu: some View {
        VStack(spacing: 10) {
            WebButton(
                title: String(localized: "privacyPolicy.aemiStudio"),
                url: aspppUrl.absoluteString,
                openDefault: true
            )
            
            WebButton(
                title: String(localized: "privacyPolicy.aploide"),
                url: adepppUrl.absoluteString,
                openDefault: true
            )
        }
    }
}
#endif

#if os(iOS)
private extension PrivacyPolicyMenuView {
    private var iOSMenu: some View {
        Menu {
            Button("Aemi Studio", systemImage: "globe") {
                isASPPPresented.toggle()
            }
            Button("Eyed Softwares", systemImage: "globe") {
                isADEPPPresented.toggle()
            }
        } label: {
            menuLabel
        }
        .sheet(isPresented: $isASPPPresented) {
            WebView(url: aspppUrl)
                .colorScheme(.light)
        }
        .sheet(isPresented: $isADEPPPresented) {
            WebView(url: adepppUrl)
        }
    }
    
    private var menuLabel: some View {
        makeStyle {
            VStack(spacing: 8) {
                HStack(alignment: .top) {
                    Text(String(localized: "privacyPolicy", comment: ""))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    Spacer()
                    Image(systemName: "circle")
                        .foregroundStyle(.clear)
                        .overlay {
                            Image(systemName: "arrow.up.forward")
                                .foregroundStyle(Color.secondary)
                        }
                        .fontWeight(.bold)
                }
                .font(.title3)
                .fontDesign(.rounded)
            }
            .padding()
        }
        .contentShape(.rect)
    }
    
    @ViewBuilder
    private func makeStyle(@ViewBuilder content: @escaping () -> some View) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            content().glass(.regular.interactive(), in: clippingShape)
        } else {
            content().background(Color.primary.quinary, in: clippingShape)
        }
    }
    
    private var clippingShape: some Shape {
        .rect(cornerRadius: UIConstants.radius)
    }
}
#endif
