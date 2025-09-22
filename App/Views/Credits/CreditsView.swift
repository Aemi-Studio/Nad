//
//  CreditsView.swift
//  Nad
//
//  Created by Guillaume Coquard on 23/08/24.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var bottomSafeAreaInset = CGFloat.zero
    
    var body: some View {
        VStack(spacing: 0) {
            collabBrands
            collabText
            
            PrivacyPolicyMenuView()
                .padding(.bottom, 32 + bottomSafeAreaInset)
        }
        .onGeometryChange(
            for: CGFloat.self,
            of: { $0.safeAreaInsets.bottom },
            action: { if $0 != bottomSafeAreaInset { bottomSafeAreaInset = $0 } }
        )
    }
    
    private var collabBrands: some View {
        Image("brands")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(Color.secondary)
            .scaleEffect(0.9)
    }
    
    private var collabText: some View {
        Text(String(localized: "collab"))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.secondary)
            .padding(.top, 26)
            .padding(.bottom, 48)
    }
}
