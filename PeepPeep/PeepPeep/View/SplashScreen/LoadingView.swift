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
                Image("PeepIcon")
                    .resizable()
                    .frame(width: 228, height: 228)
                    .padding(.top, 168)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 288)
                    Image("Logo_Typo")
                        .resizable()
                        .frame(width: 288, height: 288)
                }

            }
            .background(ignoresSafeAreaEdges: .all)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
