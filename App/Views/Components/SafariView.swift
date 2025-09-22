//
//  SafariView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import SafariServices
import SwiftUI

#if os(iOS)
private struct SafariViewRepresentable: ViewControllerRepresentable {
    let url: URL
    let color: Color?

    func makeUIViewController(
        context _: ViewControllerRepresentableContext<SafariViewRepresentable>
    ) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(
        _: SFSafariViewController,
        context _: ViewControllerRepresentableContext<SafariViewRepresentable>
    ) {
        // No need to update the view controller
    }
}
#endif

@MainActor
struct WebView: View {
    let url: URL?
    private(set) var color = Color?.none

    var body: some View {
        #if os(iOS)
        if let url {
            SafariViewRepresentable(url: url, color: color)
        }
        #endif
    }
}
