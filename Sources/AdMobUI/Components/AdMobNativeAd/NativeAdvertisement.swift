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

    @ViewBuilder private let adContent: (_ loadedAd: NativeAd?, _ error: (any Error)?) -> AdContent

    public init(
        adUnitId: String,
        @ViewBuilder adContent: @escaping (_ loadedAd: NativeAd?, _ error: (any Error)?) -> AdContent
    ) {
        self.adContent = adContent
        self.adUnitId = adUnitId

        _nativeAdLoader = StateObject(
            wrappedValue: NativeAdLoader(
                adUnitId: adUnitId
            )
        )
    }

    public var body: some View {
        let loadedAd = nativeAdLoader.loadedAd

        adContent(loadedAd, nativeAdLoader.error)
            .overlayPreferenceValue(NamedAnchorBoundsPreferenceKey.self, alignment: .center) { namedAnchors in
                GeometryReader { overlayGeometry in
                    let elementFrames: [NativeAdChildViewType: CGRect] =
                        (try? namedAnchors?.reduce<[NativeAdChildViewType: CGRect]>([:]) {
                            partialResult, namedAnchor in
                            let (name, anchor) = namedAnchor

                            let viewType: NativeAdChildViewType? = .init(rawValue: name)

                            guard let viewType else { return partialResult }

                            return partialResult.merging([viewType: overlayGeometry[anchor]]) { $1 }
                        }) ?? [:]

                    _RepresentedUINativeAdView(
                        nativeAd: loadedAd,
                        elementFrames: elementFrames
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                nativeAdLoader.loadAd()
            }
    }
}
