//
//  NativeAdvertisement.swift
//  AdMob-SwiftUI
//
//  Created by Takashi Ushikoshi on 2025/07/09.
//
//

import GoogleMobileAds
import SwiftUI

public struct NativeAdvertisement<AdContent: View>: View {
    @StateObject private var nativeAdLoader: NativeAdLoader

    private let adUnitId: String

    @ViewBuilder private let adContent: (_ advertisementPhase: NativeAdvertisementPhase, _ nativeAdLoader: NativeAdLoader) -> AdContent

    @State private var representedUINativeAdView: _RepresentedUINativeAdView? = nil
    
    public init(
        adUnitId: String,
        ofType nativeAdLoader: NativeAdLoader.Type = NativeAdLoader.self,
        listener: NativeAdListener? = nil,
        @ViewBuilder adContent: @escaping (_ advertisementPhase: NativeAdvertisementPhase, _ nativeAdLoader: NativeAdLoader) -> AdContent
    ) {
        self.adContent = adContent
        self.adUnitId = adUnitId

        _nativeAdLoader = StateObject(
            wrappedValue: nativeAdLoader.init(
                adUnitId: adUnitId,
                listener: listener
            )
        )
    }
    
    public init(
        adLoader: AdLoader,
        ofType nativeAdLoader: NativeAdLoader.Type = NativeAdLoader.self,
        listener: NativeAdListener? = nil,
        @ViewBuilder adContent: @escaping (_ advertisementPhase: NativeAdvertisementPhase, _ nativeAdLoader: NativeAdLoader) -> AdContent
    ) {
        self.adContent = adContent
        self.adUnitId = adLoader.adUnitID

        _nativeAdLoader = StateObject(
            wrappedValue: nativeAdLoader.init(
                adLoader: adLoader,
                listener: listener
            )
        )
    }

    public var body: some View {
        let loadedAd = nativeAdLoader.loadedAd

        adContent(nativeAdLoader.nativeAdvertisementPhase, nativeAdLoader)
            .overlayPreferenceValue(TypedAnchorBoundsPreferenceKey.self, alignment: .center) { namedAnchors in
                GeometryReader { overlayGeometry in
                    let elementFrames: [ElementFrame] = namedAnchors.map {
                        .init(
                            elementType: $0.viewType,
                            frame: overlayGeometry[$0.anchor]
                        )
                    }

                    representedUINativeAdView?.frame(width: overlayGeometry.size.width, height: overlayGeometry.size.height)
                    Color.clear
                        .onAppear {
                            representedUINativeAdView = _RepresentedUINativeAdView(
                                nativeAd: loadedAd,
                                elementFrames: elementFrames,
                                nativeAdLoader: nativeAdLoader
                            )
                        }
                }
            }
            .onAppear {
                nativeAdLoader.onAppear()
            }
            .onDisappear {
                nativeAdLoader.onDisappear()
            }
        
    }
}
