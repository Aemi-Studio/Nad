//
//  UIConstants.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import Foundation

struct UIConstants {

    #if os(iOS)
    static let tightRadius: CGFloat = 8
    static let radius: CGFloat = 12
    #elseif os(macOS)
    static let tightRadius: CGFloat = 4
    static let radius: CGFloat = 6
    #endif

}
