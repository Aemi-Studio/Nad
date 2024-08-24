//
//  CreditsView.swift
//  Nad
//
//  Created by Guillaume Coquard on 23/08/24.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            
            Text(NSLocalizedString("collab", comment: ""))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.secondary)

        }
    }
}

#Preview {
    CreditsView()
}
