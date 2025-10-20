//
//  NativeAdLoaderProtocol.swift
//  AdMobUI
//
//  Created by Sbtd11335 on 2025/10/14.
//

import SwiftUI
import GoogleMobileAds

open class NativeAdLoader: NSObject, ObservableObject {
    @Published private(set) var loadedAd: NativeAd?
    @Published private(set) var nativeAdvertisementPhase: NativeAdvertisementPhase = .empty
    @Published var destroyView: (() -> Void)? = nil
    private let adUnitId: String
    private let adLoader: AdLoader
    private let listener: NativeAdListener?
    
    required public init(adUnitId: String, listener: NativeAdListener? = nil) {
        self.adUnitId = adUnitId
        self.listener = listener
        adLoader = AdLoader(
            adUnitID: adUnitId,
            rootViewController: nil, adTypes: [.native],
            options: [GADAdLoaderOptions()]
        )
        super.init()
        adLoader.delegate = self
    }
    
    required public init(adLoader: AdLoader, listener: NativeAdListener? = nil) {
        self.adLoader = adLoader
        self.adUnitId = adLoader.adUnitID
        self.listener = listener
        super.init()
        adLoader.delegate = self
    }
    
    public func loadAd() {
        adLoader.load(Request())
    }
    
    open func refreshAd() {
        destroyAd()
        loadAd()
    }
    
    open func destroyAd() {
        destroyView?()
        loadedAd?.delegate = nil
        loadedAd = nil
        destroyView = nil
        nativeAdvertisementPhase = .empty
    }
    
    open func onAppear() {
        loadAd()
    }
    
    open func onDisappear() {
        destroyAd()
    }
    
    public func getLoadedAd() -> NativeAd? {
        return loadedAd
    }
}

extension NativeAdLoader: NativeAdLoaderDelegate {
    public func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        self.loadedAd = nativeAd
        self.nativeAdvertisementPhase = .success(nativeAd)
        nativeAd.delegate = self
        listener?.onAdLoaded(nativeAd: nativeAd)
    }
    
    public func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: any Error) {
        self.nativeAdvertisementPhase = .failure(error)
        listener?.onAdFailedToLoad(error: error)
    }
}

extension NativeAdLoader: NativeAdDelegate {
    public func nativeAdDidRecordImpression(_ nativeAd: NativeAd) {
        listener?.onAdImpression(nativeAd: nativeAd)
    }

    public func nativeAdDidRecordClick(_ nativeAd: NativeAd) {
        listener?.onAdClicked(nativeAd: nativeAd)
    }
}
