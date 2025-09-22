//
//  EnableCTAView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI

struct EnableCTAView: View {
    let color: Color

    var body: some View {
        Button(action: openSettings) {
            VStack(spacing: 8) {
                Text(callToActionTitleText)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)

                callToActionHelperText
                    .font(.subheadline)
                    .foregroundStyle(Color.white.secondary)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.8)
            }
        }
        .buttonStyle(CallToActionButtonStyle(color: color))
    }

    private var callToActionTitleText: String {
        #if os(iOS)
            String(localized: "enable.nad.settings")
        #elseif os(macOS)
            String(localized: "enable.nad.safari")
        #endif
    }

    private var callToActionHelperText: Text {
        callToActionBreadcrumbs.breadcrumbText()
    }

    private var callToActionBreadcrumbs: [String] {
        #if os(iOS)
            if #available(iOS 18, *) {
                [
                    String(localized: "settings.title"),
                    String(localized: "settings.apps.title"),
                    "Safari",
                    String(localized: "settings.apps.safari.extensions"),
                ]
            } else {
                [
                    String(localized: "settings.title"),
                    "Safari",
                    String(localized: "settings.apps.safari.extensions"),
                ]
            }
        #elseif os(macOS)
            [
                "Safari",
                String(localized: "settings.title"),
                String(localized: "settings.apps.safari.extensions"),
            ]
        #endif
    }

    private func openSettings() {
        #if os(iOS)
            Tools.openSettingsApplication()
        #elseif os(macOS)
            Tools.openNadExtensionPreferences()
        #endif
    }
}

private struct CallToActionButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme

    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        glassStyle {
            configuration.label
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .contentShape(.rect)
    }

    @ViewBuilder
    private func glassStyle(@ViewBuilder content: @escaping () -> some View) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            content()
                .glass(
                    .tint(color.opacity(colorScheme == .light ? 0.75 : 0.5)).interactive(),
                    in: .rect(cornerRadius: UIConstants.radius)
                )
        } else {
            content().background(color.tertiary, in: .rect(cornerRadius: UIConstants.radius))
        }
    }
}

private extension Collection where Element == String {
    func breadcrumbText(separator: Text = Text(Image(systemName: "chevron.forward"))) -> Text {
        enumerated().reduce(Text("")) { acc, element in
            let (index, part) = element
            let separator = index > 0 ? Text(" ") + separator + Text(" ") : Text("")
            return acc + separator + Text(part)
        }
    }
}
