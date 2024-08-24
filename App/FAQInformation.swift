//
//  FAQInformation.swift
//  Cami
//
//  Created by Guillaume Coquard on 09/02/24.
//

import Foundation
import SwiftUI

struct FAQInformation: Hashable, Identifiable {
    let id: UUID = UUID()
    var title: String
    var description: String

    public func lookForString(_ text: String, _ weight: Int = 0) -> Int {

        if text == "" {
            return 0 + weight
        }

        let newText = text.lowercased()
        let title = self.title.lowercased()
        let description = self.description.lowercased()

        if title.lowercased().contains(newText) || description.lowercased().contains(newText) {
            return 0 + weight
        }

        return -1
    }

    public func lookForPart(_ text: String, _ weight: Int = 0, all: Bool = false) -> Int {
        let text = text.lowercased()

        var isInTitle: Bool = true
        var isInDescription: Bool = true

        var isInAnyAtSomePoint: Bool = false

        for textPart in text.split(separator: " ") {

            let isInTitleLocal = title.contains(textPart)
            let isInDescriptionLocal = description.contains(textPart)

            isInTitle = isInTitle && isInTitleLocal
            isInDescription = isInDescription && isInDescriptionLocal

            if !isInAnyAtSomePoint {
                isInAnyAtSomePoint = isInTitleLocal || isInDescriptionLocal
            }

            if !all && isInAnyAtSomePoint {
                return 0 + weight
            }

        }

        if isInTitle || isInDescription {
            return 0 + weight
        }

        return -1
    }

    public func lookForCharsInOrder(_ text: String, _ weight: Int = 0) -> Int {
        let text = text.lowercased()

        var newTitle = self.title
        var newDesc = self.description

        var isInTitle: Bool = true
        var isInDescription: Bool = true

        for char in text {
            if isInTitle, let newTitleIndex = newTitle.firstIndex(of: char) {
                newTitle = String(newTitle[newTitle.index(after: newTitleIndex)...])
            } else {
                isInTitle = false
            }
            if isInDescription, let newDescIndex = newDesc.firstIndex(of: char) {
                newDesc = String(newDesc[newDesc.index(after: newDescIndex)...])
            } else {
                isInDescription = false
            }
            if !(isInTitle || isInDescription) {
                return -1
            }
        }
        return if isInTitle || isInDescription {
            0 + weight
        } else {
            -1
        }
    }

    public func lookFor(
        text: String,
        exact: Bool = false,
        all: Bool = false
    ) -> Int {

        if text == "" {
            return 0
        }

        let text = text.lowercased()

        let exactLookupResult: Int = self.lookForString(text, 1)

        if exactLookupResult >= 0 {
            return exactLookupResult
        } else if exact {
            return -1
        }

        let allLookupResult: Int = self.lookForPart(text, 2, all: true)

        if allLookupResult >= 0 {
            return allLookupResult
        } else if all {
            return -1
        }

        let partLookupResult: Int = self.lookForPart(text, 3, all: false)

        if partLookupResult >= 0 {
            return partLookupResult
        }

        return self.lookForCharsInOrder(text, 4)

    }
}
