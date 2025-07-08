//
//  View+.swift
//  AdMobSwiftUI
//
//  Created by Takashi Ushikoshi on 2025/07/09.
//
//

import SwiftUI

extension View {
    public func nativeAdAnchor(_ anchorViewType: NativeAdChildViewType) -> some View {
        anchorPreference(key: NamedAnchorBoundsPreferenceKey.self, value: .bounds) { anchor in
            return [anchorViewType.rawValue: anchor]
        }
    }
}
