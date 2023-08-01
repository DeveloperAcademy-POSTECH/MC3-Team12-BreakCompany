//
//  ContentView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import SwiftUI

struct ContentView: View {
    // 앱이 처음 시작할 때 로딩 상태인지 아닌지 결정
    @State private var isLoading: Bool = true

    // 사용자의 초기 설정 완료 여부
    @State private var isInitialSetupComplete: Bool = UserDefaults.shared.bool(forKey: "initialSetupComplete")

    var body: some View {
        ZStack {
            // 초기 설정이 완료된 경우 MainView를 보여줌
            if isInitialSetupComplete {
                MainView()
            }
            // 초기 설정이 완료되지 않은 경우 SplashView를 보여줌
            else {
                SplashView()
            }

            // 로딩 상태인 경우 LoadingView를 보여줌
            if isLoading {
                LoadingView()
            }
        }
        .onAppear {
            // 뷰가 나타나면 지정된 시간 후에 로딩 상태를 해제
            DispatchQueue.main.asyncAfter(deadline: .now() + (isInitialSetupComplete ? 1.0 : 3.0)) {
                isLoading = false // 로딩 상태 해제
            }
        }
    }
}
