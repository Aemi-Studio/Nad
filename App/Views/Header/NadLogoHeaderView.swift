//
//  NadLogoHeaderView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI

struct NadLogoHeaderView: View {

    var mainColor: Color
    var shadowColor: Color
    var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Image("Nad.Curve")
                .resizable()
                #if os(macOS)
                .foregroundStyle(
                colorScheme == .dark
                ? AnyShapeStyle(Material.regularMaterial)
                : AnyShapeStyle(Color(white: 0, opacity: 0.8))
                )
                #else
                .foregroundStyle(mainColor)
                #endif
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 120)
                .shadow(color: shadowColor, radius: 60)
                .shadow(color: shadowColor, radius: 30)
                .shadow(color: shadowColor, radius: 10)
        }
        .frame(height: 160)
    }
}
