//
//  NadLogoHeaderView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI

struct NadLogoHeaderView: View {
    private(set) var mainColor: Color
    private(set) var shadowColor: Color
    private(set) var colorScheme: ColorScheme

    @State private var topSafeAreaInset = CGFloat.zero

    @State private var timer = Timer.publish(every: 1 / 60, on: .main, in: .common).autoconnect()

    @State private var phase = 0.0

    var body: some View {
        image
            .frame(height: 160)
            .padding(.top, topSafeAreaInset + 32)
            .onGeometryChange(
                for: CGFloat.self,
                of: { $0.safeAreaInsets.top },
                action: { if $0 != topSafeAreaInset { topSafeAreaInset = $0 } }
            )
    }

    private var image: some View {
        Image("Nad.Curve")
            .resizable()
            .foregroundStyle(imageStyle)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 120)
            .shadow(color: shadowColor, radius: 60)
            .shadow(color: shadowColor, radius: 30)
            .shadow(color: shadowColor, radius: 10)
    }

    private var imageStyle: some ShapeStyle {
        #if os(macOS)
        if colorScheme == .dark {
            AnyShapeStyle(Material.regularMaterial)
        } else {
            AnyShapeStyle(Color(white: 0, opacity: 0.8))
        }
        #else
        mainColor
        #endif
    }
}

#Preview {
    NadLogoHeaderView(
        mainColor: .red,
        shadowColor: .red.opacity(0.4),
        colorScheme: .dark
    )
}
