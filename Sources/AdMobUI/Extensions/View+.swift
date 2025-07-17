//
//  View+.swift
//  AdMobSwiftUI
//
//  Created by Takashi Ushikoshi on 2025/07/09.
//
//

import SwiftUI

extension View {
    public func nativeAdElement(_ elementViewType: NativeAdChildViewType) -> some View {
        anchorPreference(key: TypedAnchorBoundsPreferenceKey.self, value: .bounds) { anchor in
            return [TypedAnchor(viewType: elementViewType, anchor: anchor)]
        }
    }
}
