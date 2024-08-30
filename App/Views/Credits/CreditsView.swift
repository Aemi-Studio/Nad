//
//  CreditsView.swift
//  Nad
//
//  Created by Guillaume Coquard on 23/08/24.
//

import SwiftUI

struct CreditsView: View {

    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {
        VStack(spacing: 0) {

            Image("brands")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.secondary)
                .scaleEffect(0.9)

            Text(NSLocalizedString("collab", comment: ""))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.secondary)
                .padding(.top, 26)
                .padding(.bottom, 48)

            PrivacyPolicyMenuView()
            #if os(iOS)
            .padding(.bottom, 48)
            #endif

        }
        .padding(10)
    }
}
