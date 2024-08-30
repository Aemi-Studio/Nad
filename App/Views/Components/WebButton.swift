//
//  WebButton.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import SwiftUI
#if os(macOS)
import AppKit
#endif

struct WebButton: View {

    @State
    private var isModalPresentedWebView: Bool = false

    var title: String
    var url: String
    var description: String?
    var radius: Double = 16

    var openDefault: Bool = false

    var body: some View {
        Button {
            if openDefault {
                if let url = URL(string: url) {
                    #if os(iOS)
                    UIApplication.shared.open(url)
                    #elseif os(macOS)
                    NSWorkspace.shared.open(url)
                    #endif
                }
            } else {
                isModalPresentedWebView.toggle()
            }
        } label: {
            VStack(spacing: 8) {
                HStack(alignment: .top) {
                    Text(title)
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
        }
        .buttonStyle(InformationButtonStyle())
        .contextMenu {
            Button("Open in your default browser", systemImage: "arrow.up.forward.square") {
                if let url = URL(string: url) {
                    #if os(iOS)
                    UIApplication.shared.open(url)
                    #elseif os(macOS)
                    NSWorkspace.shared.open(url)
                    #endif
                }
            }
        }

        #if os(iOS)
        .fullScreenCover(isPresented: $isModalPresentedWebView) {
        SafariView(url: URL(string: url)!)
        }
        #endif
    }
}
