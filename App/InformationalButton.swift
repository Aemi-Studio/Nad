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
                    Spacer()
                    Image(systemName: "circle")
                        .foregroundStyle(.clear)
                        .overlay {
                            Image(
                                systemName: showMore ? "xmark" : "chevron.forward"
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


fileprivate struct InformationButtonStyle: ButtonStyle {

    @ViewBuilder
    func makePadding(@ViewBuilder content: @escaping () -> some View ) -> some View {
        content()
            .padding()
            .background(Color.primary.quinary)
            .clipShape(.rect(cornerRadius: 12))
    }

    func makeBody(configuration: Configuration) -> some View {
        makePadding {
            configuration.label
        }
    }

}
