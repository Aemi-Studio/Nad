//
//  VisualEffectView.swift
//  Nad
//
//  Created by Guillaume Coquard on 29/08/24.
//

#if os(macOS)
    import SwiftUI

    struct VisualEffectView: NSViewRepresentable {
        func makeNSView(context _: Context) -> NSVisualEffectView {
            let effectView = NSVisualEffectView()
            effectView.state = .active
            return effectView
        }

        func updateNSView(_: NSVisualEffectView, context _: Context) {}
    }

    extension View {
        func blurryBackground() -> some View {
            background(VisualEffectView().ignoresSafeArea())
        }
    }
#endif
