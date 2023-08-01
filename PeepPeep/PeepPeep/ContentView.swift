//
//  ContentView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoading: CGFloat = 1.0
    
    var body: some View {
        ZStack{
            SplashView()
                .opacity(isLoading == 0.0 ? 1.0 : 0.0)
                .animation(nil)
           
            LoadingView()
                .opacity(isLoading)
                .animation(.easeOut(duration: 1))
            
        }
        .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeIn(duration: 1)) {
                            isLoading = 0.0
                        }
                    }
                }
//        .onAppear {
//            withAnimation(.easeIn(duration: 1)) {
//                isLoading = 0.0
//            }
//        }
    }
}
