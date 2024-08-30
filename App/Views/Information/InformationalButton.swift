//
//  InformationalButton.swift
//  Nad
//
//  Created by Guillaume Coquard on 23/08/24.
//

import SwiftUI

struct InformationalButton: View {

    var title: String
    var content: String

    @State
    private var showMore: Bool = false

    var body: some View {
        Button {
            withAnimation {
                showMore.toggle()
            }
        } label: {
            VStack(spacing: 8) {
                HStack(alignment: .top) {
                    Text(title)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .fontWeight(.semibold)
                        .foregroundStyle(showMore
                                            ? AnyShapeStyle(Color.primary.tertiary)
                                            : AnyShapeStyle(Color.primary))
                    Spacer()
                    Image(systemName: "circle")
                        .foregroundStyle(.clear)
                        .overlay {
                            Image(
                                systemName: showMore ? "minus" : "plus"
                            )
                            .foregroundStyle(Color.secondary)
                        }
                        .fontWeight(.bold)
                }
                .font(.title3)

                .fontDesign(.rounded)
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
        }
        .buttonStyle(InformationButtonStyle())
    }
}

struct InformationButtonStyle: ButtonStyle {

    var color: Color = Color.primary

    @ViewBuilder
    func makePadding(@ViewBuilder content: @escaping () -> some View ) -> some View {
        content()
            .padding()
            .background(color.quinary)
            .clipShape(.rect(cornerRadius: UIConstants.radius))
    }

    func makeBody(configuration: Configuration) -> some View {
        makePadding {
            configuration.label
        }
    }

}
