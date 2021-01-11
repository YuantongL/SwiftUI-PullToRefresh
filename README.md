# SwiftUI-PullToRefresh

## Introduction
SwiftUI's ScrollView does not support pull down to refresh, this is a library that adds refresh control to it.

<img src="https://github.com/YuantongL/SwiftUI-PullToRefresh/blob/main/ScreenRecording/ScreenRecording.gif?raw=true" width="320" height="571" />

## Install
- Cocoapod. `pod SwiftUI-PullToRefresh`

- SPM. `https://github.com/YuantongL/SwiftUI-PullToRefresh.git`

- Simply copy the source file under `/Source/RefreshableScrollView.swift`

## Usage
Use the RefreshableScrollView component from this library as below:
```
@State private var isLoading: Bool = false

RefreshableScrollView(isLoading: $isLoading,
                      onRefresh: {
                        // Update your data and
                        self.isLoading = false
                      },
                      content: {
                          // Draw your content view here
                      })
```
You can also checkout the example app.
