//
//  SplashView.swift
//  PeepPeep
//
//  Created by 예슬 on 2023/07/12.
//
import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Text("이상한 아저씨가 학교 앞에서 무엇인가 팔고 있다")
                .font(.custom("DOSSaemmul", size: 18))
                .lineSpacing(19)
                .multilineTextAlignment(.center)
                .frame(width: 300)
                
            Image("BoxOff")
                .resizable()
                .frame(width: 300, height: 350)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
