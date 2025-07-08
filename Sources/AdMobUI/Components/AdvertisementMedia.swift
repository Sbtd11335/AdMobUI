//
//  AdvertisementMedia.swift
//  AdMob-SwiftUI
//  
//  Created by Takashi Ushikoshi on 2025/07/09.
//  
//


import SwiftUI
import GoogleMobileAds

public struct AdvertisementMedia: View {
    private var mediaContent: MediaContent?

    public init(mediaContent: MediaContent? = nil) {
        self.mediaContent = mediaContent
    }

    public var body: some View {
        _RepresentedAdMobMedia(mediaContent: mediaContent)
            .nativeAdAnchor(.media)
    }
}
