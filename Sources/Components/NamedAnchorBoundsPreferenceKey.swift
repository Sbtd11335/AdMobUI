//
//  NamedAnchorBoundsPreferenceKey.swift
//  AdMobSwiftUI
//  
//  Created by Takashi Ushikoshi on 2025/07/09.
//  
//

import SwiftUI

internal struct NamedAnchorBoundsPreferenceKey: PreferenceKey {
    typealias Value = [String: SwiftUI.Anchor<CGRect>]?

    static func reduce(value: inout [String : SwiftUI.Anchor<CGRect>]?, nextValue: () -> [String : SwiftUI.Anchor<CGRect>]?) {
        value = nextValue()
    }
}
