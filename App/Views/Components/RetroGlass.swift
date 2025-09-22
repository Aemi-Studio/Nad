//
//  RetroGlass.swift
//  Nad
//
//  Created by Guillaume Coquard on 21.09.25.
//

import SwiftUI

extension View {
    @ViewBuilder func glass(_ effect: RetroGlass = .regular, in shape: some Shape = .defaultGlassShape) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            glassEffect(effect.resolvedValue, in: shape)
        } else {
            self
        }
    }
}

struct RetroGlass: Sendable, Equatable {
    private enum GlassVariant: Sendable, Equatable {
        case clear
        case identity
        case regular
    }

    private var _variant: GlassVariant = .regular
    private var _color: Color?
    private var _interactive: Bool = false

    private init(variant _: GlassVariant = .regular, color: Color? = nil, interactive: Bool = false) {
        _color = color
        _interactive = interactive
    }

    func tint(_ color: Color) -> Self {
        Self(variant: _variant, color: color, interactive: _interactive)
    }

    func interactive() -> Self {
        Self(variant: _variant, color: _color, interactive: true)
    }

    func regular() -> Self {
        Self(variant: .regular, color: _color, interactive: _interactive)
    }

    func clear() -> Self {
        Self(variant: .clear, color: _color, interactive: _interactive)
    }

    func identity() -> Self {
        Self(variant: .identity, color: _color, interactive: _interactive)
    }

    @available(iOS 26.0, macOS 26.0, *)
    var resolvedValue: Glass {
        let baseGlass: Glass = switch _variant {
        case .clear: .clear
        case .identity: .identity
        case .regular: .regular
        }

        let coloredGlass: Glass = if let _color {
            baseGlass.tint(_color)
        } else {
            baseGlass
        }

        return _interactive ? coloredGlass.interactive() : coloredGlass
    }

    static var regular: Self {
        Self(variant: .regular)
    }

    static var clear: Self {
        Self(variant: .clear)
    }

    static var identity: Self {
        Self(variant: .identity)
    }

    static var interactive: Self {
        Self(interactive: true)
    }

    static func tint(_ color: Color?) -> Self {
        Self(color: color)
    }
}

extension Shape where Self == AnyShape {
    static var defaultGlassShape: AnyShape {
        if #available(iOS 26.0, macOS 26.0, *) {
            AnyShape(DefaultGlassEffectShape())
        } else {
            AnyShape(.containerRelative)
        }
    }
}

private struct RetroGlassButtonStyle: ButtonStyle {
    private(set) var isProminent: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            if isProminent {
                configuration.label
                    .buttonStyle(.glassProminent)
            } else {
                configuration.label
                    .buttonStyle(.glass)
            }
        } else {
            configuration.label
        }
    }
}

extension ButtonStyle where Self == RetroGlassButtonStyle {
    static var retroGlass: Self {
        RetroGlassButtonStyle()
    }

    static var retroGlassProminent: Self {
        RetroGlassButtonStyle(isProminent: true)
    }
}
