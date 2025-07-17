//
//  NativeAdvertisementPhase.swift
//  Simple ID Photo
//  
//  Created by Takashi Ushikoshi on 2025/07/18.
//  
//

import GoogleMobileAds

public enum NativeAdvertisementPhase: Sendable {
    case empty
    case success(NativeAd)
    case failure(any Error)

    public var nativeAd: NativeAd? {
        switch self {
        case .success(let ad):
            return ad
        default:
            return nil
        }
    }

    public var error: (any Error)? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}
