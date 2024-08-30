//
//  EnableCTAView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI

struct EnableCTAView: View {

    @ViewBuilder
    private var helperText: some View {
        #if os(iOS)
        if #available(iOS 18, *) {
            Text(NSLocalizedString("settings.title", comment: ""))
                + Text(" ")
                + Text(Image(systemName: "chevron.forward"))
                + Text(" ")
                + Text(NSLocalizedString("settings.apps.title", comment: ""))
                + Text(" ")
                + Text(Image(systemName: "chevron.forward"))
                + Text(" ")
                + Text("Safari")
                + Text(" ")
                + Text(Image(systemName: "chevron.forward"))
                + Text(" ")
                + Text(NSLocalizedString("settings.apps.safari.extensions", comment: ""))
        } else {
            Text(NSLocalizedString("settings.title", comment: ""))
                + Text(" ")
                + Text(Image(systemName: "chevron.forward"))
                + Text(" ")
                + Text("Safari")
                + Text(" ")
                + Text(Image(systemName: "chevron.forward"))
                + Text(" ")
                + Text(NSLocalizedString("settings.apps.safari.extensions", comment: ""))
        }
        #elseif os(macOS)
        Text("Safari")
            + Text(" ")
            + Text(Image(systemName: "chevron.forward"))
            + Text(" ")
            + Text(NSLocalizedString("settings.title", comment: ""))
            + Text(" ")
            + Text(Image(systemName: "chevron.forward"))
            + Text(" ")
            + Text(NSLocalizedString("settings.apps.safari.extensions", comment: ""))
        #endif
    }

    var body: some View {
        VStack(spacing: 8) {
            Group {
                #if os(iOS)
                Text(NSLocalizedString("enable.nad.settings", comment: ""))
                #elseif os(macOS)
                Text(NSLocalizedString("enable.nad.safari", comment: ""))
                #endif
            }
            .font(.title3)
            .fontWeight(.bold)
            helperText
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.red.tertiary)
        .clipShape(.rect(cornerRadius: UIConstants.radius))
        .contentShape(.rect)
        .onTapGesture {
            #if os(iOS)
            Tools.openSettingsApplication()
            #elseif os(macOS)
            Tools.openNadExtensionPreferences()
            #endif
        }
        .padding(.top)
        .padding(.horizontal, 10)
    }
}
