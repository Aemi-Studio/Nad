//
//  VisualEffectView.swift
//  Nad
//
//  Created by Guillaume Coquard on 29/08/24.
//

#if os(macOS)
import Foundation
import SwiftUI

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.state = .active
        return effectView
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
    }
}

extension View {
    func blurryBackground() -> some View {
        self
            .background(VisualEffectView().ignoresSafeArea())
    }
}

#endif
