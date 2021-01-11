//
//  ContentView.swift
//  SwiftUI-PullToRefreshExampleApp
//
//  Created by Lyt on 1/10/21.
//

import SwiftUI
import SwiftUI_PullToRefresh

struct ContentView: View {

    @State
    private var data = [1,2,3,4,5,6,7,8]
    private let dataAfterRefresh = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]

    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView {
            RefreshableScrollView(isLoading: $isLoading,
                                  onRefresh: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        self.data = dataAfterRefresh
                                        self.isLoading = false
                                    }
                                  },
                                  content: {
                                    VStack {
                                        ForEach(data, id: \.self) { element in
                                            Text("\(element)")
                                            Divider()
                                        }
                                    }
                                  })
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Nav Title")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
