//
//  NativeAdLoaderProtocol.swift
//  AdMobUI
//
//  Created by Sbtd11335 on 2025/10/14.
//

import SwiftUI
import GoogleMobileAds

open class NativeAdLoader: NSObject, ObservableObject, NativeAdLoaderDelegate {
    @Published private(set) var loadedAd: NativeAd?
    @Published private(set) var nativeAdvertisementPhase: NativeAdvertisementPhase = .empty
    private let adUnitId: String
    private let adLoader: AdLoader
    
    required public init(adUnitId: String) {
        self.adUnitId = adUnitId
        adLoader = AdLoader(
            adUnitID: adUnitId,
            rootViewController: nil, adTypes: [.native],
            options: [GADAdLoaderOptions()]
        )
        super.init()
        adLoader.delegate = self
    }
    
    required public init(adLoader: AdLoader) {
        self.adLoader = adLoader
        self.adUnitId = adLoader.adUnitID
        super.init()
        adLoader.delegate = self
    }
    
    open func loadAd() {
        adLoader.load(Request())
    }
    
    open func onAppear() {
        loadAd()
    }
    
    open func onDisappear() {}
    
    public func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        self.loadedAd = nativeAd
        self.nativeAdvertisementPhase = .success(nativeAd)
    }
    
    public func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: any Error) {
        self.nativeAdvertisementPhase = .failure(error)
    }
}
