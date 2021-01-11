//
//  RefreshableScrollView.swift
//  FSUIComponents
//
//  Created by Lyt on 1/8/21.
//

import Foundation
import SwiftUI

struct ScrollViewDragOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

public struct RefreshableScrollView<Content>: View where Content: View {

    @Environment(\.colorScheme)
    private var colorScheme

    private let pullThreshold: CGFloat = -60

    @State
    private var readyForNextPull = true

    @State
    private var dragTransitionHeight: CGFloat = 0 {
        didSet {
            if !isLoading, dragTransitionHeight < pullThreshold, readyForNextPull {
                readyForNextPull = false
                isLoading = true
                onRefresh()
                return
            }

            if isLoading, dragTransitionHeight > pullThreshold {
                withAnimation(.easeOut) {
                    scrollViewOffset = -pullThreshold
                }
            }

            if dragTransitionHeight == 0 {
                readyForNextPull = true
            }
        }
    }

    @State
    private var scrollViewOffset: CGFloat = 0

    private let content: Content

    @Binding
    private var isLoading: Bool

    private var onRefresh: () -> Void

    public init(isLoading: Binding<Bool>,
                onRefresh: @escaping () -> Void,
                @ViewBuilder content: @escaping () -> Content) {
        self._isLoading = isLoading
        self.content = content()
        self.onRefresh = onRefresh
    }

    public var body: some View {
        ZStack(alignment: .top) {
            if isLoading {
                ProgressView()
                    .padding()
                    .opacity(dragTransitionHeight > 0 ? 0.0 : 1.0)
            } else {
                Image(systemName: "arrow.clockwise.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .rotationEffect(Angle(degrees: Double(-2 * dragTransitionHeight)))
                    .padding()
                    .opacity(dragTransitionHeight > 0 ? 0.0 : 1.0)
            }

            GeometryReader { outsideProxy in
                ScrollView {
                    VStack {
                        GeometryReader { insideProxy in
                            Color.clear
                                .preference(key: ScrollViewDragOffsetPreferenceKey.self,
                                            value: outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY)
                        }
                        .onPreferenceChange(ScrollViewDragOffsetPreferenceKey.self) { newValue in
                            dragTransitionHeight = newValue
                        }

                        content

                        Spacer()
                    }
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .offset(x: 0, y: scrollViewOffset)
                    .onChange(of: isLoading, perform: { _ in
                        if !isLoading {
                            withAnimation {
                                scrollViewOffset = 0
                            }
                        }
                    })
                }
            }
        }
    }
}

struct RefreshableScrollViewDemoView: View {

    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView {
            RefreshableScrollView(isLoading: $isLoading,
                                  onRefresh: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        self.isLoading = false
                                    }
                                  },
                                  content: {
                                    Text("123 \(isLoading.description)")
                                        .frame(maxHeight: .infinity)
                                  })
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Nav Title")
        }
    }
}

struct RefreshableScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableScrollViewDemoView()
    }
}
