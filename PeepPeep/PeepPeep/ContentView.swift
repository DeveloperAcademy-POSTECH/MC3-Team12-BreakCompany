//
//  ContentView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: CGFloat = 1.0
    @State var isInitialSetupComplete: Bool = UserDefaults.shared.bool(forKey: "initialSetupComplete")

    var body: some View {
        ZStack {
            if isInitialSetupComplete {
                MainView()
            }
            else {
                SplashView()
                    .opacity(isLoading == 0.0 ? 1.0 : 0.0)
                    .animation(nil)
            }
            LoadingView()
                .opacity(isLoading)
                .animation(.easeOut(duration: 1))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + (isInitialSetupComplete ? 1.0 : 3.0)) {
                withAnimation(.easeIn(duration: 1)) {
                    isLoading = 0.0
                }
            }
        }
    }
}
