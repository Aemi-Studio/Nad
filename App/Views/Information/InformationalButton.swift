//
//  InformationalButton.swift
//  Nad
//
//  Created by Guillaume Coquard on 23/08/24.
//

import SwiftUI

struct InformationalButton: View {
    private(set) var title: String
    private(set) var content: String

    @State private var showMore: Bool = false
    
    private var buttonHeadlineStyle: some ShapeStyle {
        if showMore {
            AnyShapeStyle(Color.primary.tertiary)
        } else {
            AnyShapeStyle(Color.primary)
        }
    }
    
    private var buttonHeadline: some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
            .fontWeight(.semibold)
            .foregroundStyle(buttonHeadlineStyle)
    }
    
    private var buttonIcon: some View {
        Image(systemName: "circle")
            .foregroundStyle(.clear)
            .overlay {
                Group {
                    if showMore {
                        Image(systemName: "minus")
                    } else {
                        Image(systemName: "plus")
                    }
                }
                .transition(.opacity.combined(with: .blurReplace).combined(with: .symbolEffect))
                .id("buttonIcon-\(showMore)")
                .foregroundStyle(Color.secondary)
            }
            .fontWeight(.bold)
    }

    private var buttonLabel: some View {
        HStack(alignment: .top) {
            buttonHeadline
            Spacer()
            buttonIcon
        }
        .font(.title3)
        .fontDesign(.rounded)
    }
    
    private var buttonDisclosableContent: some View {
        Group {
            if showMore {
                VStack(alignment: .leading) {
                    HStack {
                        Text(content)
                            .multilineTextAlignment(.leading)
                            .lineLimit(20)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .font(.headline)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .transition(.opacity.combined(with: .blurReplace).combined(with: .symbolEffect))
        .id("buttonDisclosableContent-\(showMore)")
    }
    
    var body: some View {
        Button {
            withAnimation(.smooth) {
                showMore.toggle()
            }
        } label: {
            VStack(spacing: 8) {
                buttonLabel
                buttonDisclosableContent
            }
            .animation(.smooth, value: showMore)
        }
        .buttonStyle(.information)
    }
}
