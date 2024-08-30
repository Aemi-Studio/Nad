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
                title: NSLocalizedString("howdoesitwork.title", comment: ""),
                content: NSLocalizedString("howdoesitwork.explanation", comment: "")
            )

            InformationalButton(
                title: NSLocalizedString("doesitblockyoutube.title", comment: ""),
                content: NSLocalizedString("doesitblockyoutube.explanation", comment: "")
            )

            InformationalButton(
                title: NSLocalizedString("doweknowtrafic.title", comment: ""),
                content: NSLocalizedString("doweknowtrafic.explanation", comment: "")
            )

            InformationalButton(
                title: NSLocalizedString("dowesavedata.title", comment: ""),
                content: NSLocalizedString("dowesavedata.explanation", comment: "")
            )

        }
        .padding(10)
        .zIndex(100)
    }
}
