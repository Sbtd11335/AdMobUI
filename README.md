# AdMobUI

AdMobUI allows you to create AdMob native ads with fully SwiftUI.

## Example

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
