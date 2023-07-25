//
//  ContentView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack{
            SplashView()
            
            if isLoading {
                LoadingView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                isLoading.toggle()
            })
        }
    }
}
