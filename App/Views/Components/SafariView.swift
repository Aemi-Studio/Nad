//
//  SafariView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import SwiftUI
import SafariServices

#if os(iOS)

struct SafariView: ViewControllerRepresentable {

    let url: URL

    func makeUIViewController(
        context: ViewControllerRepresentableContext<SafariView>
    ) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: ViewControllerRepresentableContext<SafariView>
    ) {
        // No need to update the view controller
    }
}
#endif
