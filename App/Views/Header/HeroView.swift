//
//  HeroView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI

struct HeroView: View {

    @Environment(\.colorScheme)
    private var colorScheme

    @Environment(BlockerState.self)
    private var blockerState

    private var isEnabled: Bool {
        blockerState.isEnabled
    }

    private var enabledColor: Color {
        isEnabled ? .green : .red
    }

    private var nadColor: Color {
        colorScheme == .dark ? .background : enabledColor
    }

    private var shadowColor: Color {
        colorScheme == .dark ? enabledColor : enabledColor.opacity(0.5)
    }

    var body: some View {
        VStack(spacing: 32) {

            NadLogoHeaderView(
                mainColor: nadColor,
                shadowColor: shadowColor,
                colorScheme: colorScheme
            )

            VStack {
                VStack(spacing: 12) {
                    Text("nad")
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                        .fontWeight(.black)
                        .zIndex(100)

                    VStack {
                        Text(isEnabled ? "enabled" : "disabled")
                            .font(.headline)
                            .fontWidth(.expanded)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .textCase(.uppercase)
                            .kerning(1)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(enabledColor)
                    .clipShape(.rect(cornerRadius: UIConstants.tightRadius))
                    .shadow(color: shadowColor.opacity(0.1), radius: 30)
                    .shadow(color: shadowColor.opacity(0.2), radius: 15)
                    .shadow(color: shadowColor.opacity(0.4), radius: 5)

                }
                if !isEnabled {
                    EnableCTAView()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 64)
        .padding(.bottom, isEnabled ? 48 : 6)
    }
}
