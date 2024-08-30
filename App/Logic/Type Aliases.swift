//
//  Type Aliases.swift
//  Nad
//
//  Created by Guillaume Coquard on 30/08/24.
//

import SwiftUI

#if os(macOS)
import AppKit
typealias ViewRepresentable = NSViewRepresentable
typealias ViewControllerRepresentable = NSViewControllerRepresentable
typealias ViewControllerRepresentableContext = NSViewControllerRepresentableContext
#else
import UIKit
typealias ViewRepresentable = UIViewRepresentable
typealias ViewControllerRepresentable = UIViewControllerRepresentable
typealias ViewControllerRepresentableContext = UIViewControllerRepresentableContext
#endif
