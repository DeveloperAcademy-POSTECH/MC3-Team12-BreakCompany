//
//  HelperView.swift
//  PeepPeep
//
//  Created by 이승용 on 2023/07/25.
//

import SwiftUI

struct HelperView: View {
    var body: some View {
        VStack{
            Text("병아리의 스트레스 지수")
                .font(.system(size:20))
            
            // MARK: Happy Chick
            HStack{
                Image("Happy 1")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("기분 체고!")
                        .font(.system(size:16))
                    Image("Happy 2")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("0~20%")
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            
            // MARK: Base Chick,
            HStack{
                Image("Base 1")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("나쁘지 않아")
                        .font(.system(size:16))
                    Image("Base 2")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("20~40%")
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            
            // MARK: Sad Chick
            HStack{
                Image("Sad 1")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("고만 좀 만져라..")
                        .font(.system(size:16))
                    Image("Sad 2")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("40~60%")
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            
            // MARK: SoSad Chick
            HStack{
                Image("SoSad 1")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("살려조라ㅠ")
                        .font(.system(size:16))
                    Image("SoSad 2")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("60~80%")
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            
            // MARK: Angry Chick
            HStack{
                Image("Angry 1")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("%$#^&@!")
                        .font(.system(size:16))
                    Image("Angry 2")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("80~100%")
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 0))
            
            Text("목표한 시간을 잘 지키면 병아리는 성장하고, \n 사용 시간을 초과하면 무서운 일이 일어납니다.")
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 350, height: 61)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black)
                )
        }   // VStack
    }
}

struct HelperView_Previews: PreviewProvider {
    static var previews: some View {
        HelperView()
    }
}

