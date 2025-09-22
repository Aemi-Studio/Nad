//
//  HeroView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI

struct HeroView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(BlockerState.self) private var blockerState

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                appTitle
                stateBadge
            }
            if showCTA {
                EnableCTAView(color: stateColor)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var appTitle: some View {
        Text("nad")
            .font(.largeTitle)
            .fontWidth(.expanded)
            .fontWeight(.black)
    }

    private var showCTA: Bool {
        switch blockerState.state {
        case .disabled, .error, .unknown:
            true
        default:
            false
        }
    }
}

private extension HeroView {
    private var stateBadge: some View {
        badgeEffect {
            VStack {
                stateTextView
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
        }
    }

    @ViewBuilder private var stateTextView: some View {
        switch blockerState.state {
        case .unknown:
            ProgressView().progressViewStyle(.circular).tint(.white)
        default:
            Text(blockerState.state.description)
        }
    }

    @ViewBuilder private func badgeEffect(@ViewBuilder content: @escaping () -> some View) -> some View {
        Group {
            if #available(iOS 26.0, macOS 26.0, *) {
                content()
                    .glass(.regular.tint(stateColor), in: .rect(cornerRadius: UIConstants.tightRadius))
            } else {
                content()
                    .background(stateColor, in: .rect(cornerRadius: UIConstants.tightRadius))
            }
        }
        .shadow(color: shadowColor.opacity(0.1), radius: 30)
        .shadow(color: shadowColor.opacity(0.2), radius: 15)
        .shadow(color: shadowColor.opacity(0.4), radius: 5)
    }
}

private extension HeroView {
    private var isEnabled: Bool {
        blockerState.state.boolean
    }

    private var stateColor: Color {
        blockerState.state.color
    }

    private var shadowColor: Color {
        colorScheme == .dark ? stateColor : stateColor.opacity(0.5)
    }
}
