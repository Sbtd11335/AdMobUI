//
//  _UINativeAdView.swift
//  AdMob-SwiftUI
//  
//  Created by Takashi Ushikoshi on 2025/07/09.
//  
//


import SwiftUI
import GoogleMobileAds

internal class _UINativeAdView: NativeAdView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
