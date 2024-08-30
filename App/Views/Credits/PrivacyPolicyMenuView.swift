//
//  PrivacyPolicyMenuView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import SwiftUI

struct PrivacyPolicyMenuView: View {

    private let aspppUrl: URL = URL(string: "https://aemi.studio/privacy")!
    private let adepppUrl: URL = URL(string: "https://aploi.de/privacy")!

    @State
    private var isASPPPresented: Bool = false {
        didSet {
            if isASPPPresented {
                #if os(macOS)
                NSWorkspace.shared.open(aspppUrl)
                #endif
            }
        }
    }

    @State
    private var isADEPPPresented: Bool = false {
        didSet {
            if isADEPPPresented {
                #if os(macOS)
                NSWorkspace.shared.open(adepppUrl)
                #endif
            }
        }
    }

    var body: some View {

        #if os(iOS)

        Menu {
            Button("Aemi Studio", systemImage: "globe") {
                isASPPPresented.toggle()
            }
            Button("APLOI.DE", systemImage: "globe") {
                isADEPPPresented.toggle()
            }
        } label: {
            VStack(spacing: 8) {
                HStack(alignment: .top) {
                    Text(NSLocalizedString("privacyPolicy", comment: ""))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "circle")
                        .foregroundStyle(.clear)
                        .overlay {
                            Image(
                                systemName: "arrow.up.forward"
                            )
                            .foregroundStyle(Color.secondary)
                        }
                        .fontWeight(.bold)
                }
                .font(.title3)
                .fontDesign(.rounded)
            }
            .padding()
            .background(Color.primary.quinary)
            .clipShape(.rect(cornerRadius: UIConstants.radius))
            .contentShape(.rect)
            .foregroundStyle(Color.primary)
        }
        .fullScreenCover(isPresented: $isASPPPresented) {
            SafariView(url: aspppUrl)
        }
        .fullScreenCover(isPresented: $isADEPPPresented) {
            SafariView(url: adepppUrl)
        }
        #else
        VStack(spacing: 10) {
            WebButton(
                title: NSLocalizedString("privacyPolicy.aemiStudio", comment: ""),
                url: aspppUrl.absoluteString,
                openDefault: true
            )

            WebButton(
                title: NSLocalizedString("privacyPolicy.aploide", comment: ""),
                url: adepppUrl.absoluteString,
                openDefault: true
            )
        }
        #endif

    }

}
