//
//  TypedAnchorBoundsPreferenceKey.swift
//  AdMobSwiftUI
//
//  Created by Takashi Ushikoshi on 2025/07/09.
//
//

import SwiftUI

internal struct TypedAnchorBoundsPreferenceKey: PreferenceKey {
    static var defaultValue: [TypedAnchor] = []

    static func reduce(
        value: inout [TypedAnchor],
        nextValue: () -> [TypedAnchor]
    ) {
        // nextValue always returns single or no elements because inside anchorPreference modifier returns an array containing a single element.
        let nextValueElement = nextValue().first

        // If nextValueElement is nil, it means there are no new anchors to process.
        guard let nextValueElement else { return }

        // if the nextValueElement already exists in the value array,
        // update its anchor instead of appending a new one.
        if let existingTypedAnchor = value.first(where: { $0.viewType == nextValueElement.viewType }) {
            let updatedTypedAnchor: TypedAnchor = .init(
                viewType: existingTypedAnchor.viewType,
                anchor: nextValueElement.anchor
            )

            let existingElementRemovedAnchors = value.filter { $0.viewType != existingTypedAnchor.viewType }

            value = existingElementRemovedAnchors + [updatedTypedAnchor]

            return
        }

        value.append(nextValueElement)
    }
}
