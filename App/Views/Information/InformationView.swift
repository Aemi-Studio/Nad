//
//  InformationView.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation
import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack(spacing: 10) {
            InformationalButton(
                title: String(localized: "howdoesitwork.title"),
                content: String(localized: "howdoesitwork.explanation")
            )

            InformationalButton(
                title: String(localized: "doesitblockyoutube.title"),
                content: String(localized: "doesitblockyoutube.explanation")
            )

            InformationalButton(
                title: String(localized: "doweknowtrafic.title"),
                content: String(localized: "doweknowtrafic.explanation")
            )

            InformationalButton(
                title: String(localized: "dowesavedata.title"),
                content: String(localized: "dowesavedata.explanation")
            )
        }
    }
}



extension View {
    func track(height: Binding<CGFloat>) -> some View {
        onGeometryChange(
            for: CGFloat.self,
            of: { $0.size.height },
            action: { if $0 != height.wrappedValue { height.wrappedValue = $0 } }
        )
    }
}
