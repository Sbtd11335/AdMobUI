//
//  NativeAdListener.swift
//  AdMobUI
//
//  Created by sbtd11335 on 2025/10/18.
//

import GoogleMobileAds

open class NativeAdListener {
    public init() {}
    open func onAdFailedToLoad(error: any Error) {}
    open func onAdLoaded(nativeAd: NativeAd) {}
    open func onAdImpression(nativeAd: NativeAd) {}
    open func onAdClicked(nativeAd: NativeAd) {}
}
