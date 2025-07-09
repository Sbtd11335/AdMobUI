# AdMobUI

AdMobUI allows you to create AdMob native ads with fully SwiftUI.

## How it works

AdMobUI works by overlaying an invisible `NativeAdView` on top of a SwiftUI view given inside the `NativeAdvertisement` closure.  

Each element of the native ad provided to the closure can be annotated with the `nativeAdAnchor` modifier, which automatically aligns and sizes the transparent `NativeAdView` overlay.  

Internally, `nativeAdAnchor` uses `anchorPreference` and `overlayPreferenceValue` to capture the bounds of the annotated elements, enabling the layout of `NativeAdView` to be computed automatically.

## Example

AdMobUI provides a `NativeAdvertisement` view that you can use to display native ads in your SwiftUI applications. You can customize the appearance of the ad by providing a closure that returns a view with the ad's content.

```swift
import AdMobUI

struct ContentView: View {
    var body: some View {
        List {
            NativeAdvertisement(adUnitId: "ca-pub-xxxxxx") { loadedAd, _ in
                HStack {
                    if let icon = loadedAd.icon.image {
                        Image(uiImage: icon)
                            .resizable()
                            .scaledtoFit()
                            .nativeAdAnchor(.icon)
                    }
    
                    VStack {
                        if let headline = loadedAd.headline {
                            Text(headline)
                                .font(.headline)
                                .nativeAdAnchor(.headline)
                        }

                        if let body = loadedAd.body {
                            Text(body)
                                .nativeAdAnchor(.body)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .listRowInsets(EdgeInsets())
        }
    }
}
```

## TODO

- [ ] Implement support to inject custom AdLoader implementations.
  ```swift
  NativeAdvertisement { loadedAd in
      // .... layout some ad
  }
  .environment(\.adLoader, CustomAdLoader())
  ```
  