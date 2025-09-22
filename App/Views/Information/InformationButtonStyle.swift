//
//  InformationButtonStyle.swift
//  Nad
//
//  Created by Guillaume Coquard on 22.09.25.
//

import SwiftUI

extension ButtonStyle where Self == InformationButtonStyle {
    static var information: some ButtonStyle { InformationButtonStyle() }
}


struct InformationButtonStyle: ButtonStyle {
    private(set) var color = Color.primary

    func makeBody(configuration: Configuration) -> some View {
        makeStyle {
            makePadding {
                configuration.label
            }
        }
        .contentShape(.rect)
    }
    
    private var clippingShape: some Shape {
        .rect(cornerRadius: UIConstants.radius)
    }
    
    @ViewBuilder
    private func makePadding(@ViewBuilder content: @escaping () -> some View) -> some View {
        content().padding()
    }
    
    @ViewBuilder
    private func makeStyle(@ViewBuilder content: @escaping () -> some View) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            content().glass(.regular.interactive(), in: clippingShape)
        } else {
            content().background(color.quinary, in: clippingShape)
        }
    }
}
