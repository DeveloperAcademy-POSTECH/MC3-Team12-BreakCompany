//
//  LoadingView.swift
//  PeepPeep
//
//  Created by 예슬 on 2023/07/26.
//

import SwiftUI

struct LoadingView: View {
    
    @State var isLoading: Bool = true
    
    var body: some View {
//        ZStack {
            VStack {
                Image("appstore")
                    .resizable()
                    .frame(width: 228, height: 228)
                    .padding(.top, 168)
                //.opacity(loadingViewOpacity)
                
                Image("Logo_Typo")
                    .resizable()
                    .frame(width: 288, height: 288)
                //.opacity(loadingViewOpacity)
                
//                if isLoading {
//                    SplashView()
//                }
            }
            .background(ignoresSafeAreaEdges: .all)
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                isLoading.toggle()
//            })
//        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
