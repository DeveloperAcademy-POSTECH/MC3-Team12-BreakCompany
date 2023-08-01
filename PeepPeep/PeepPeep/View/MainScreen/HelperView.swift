//
//  HelperView.swift
//  PeepPeep
//
//  Created by 이승용 on 2023/07/25.
//

import SwiftUI

struct HelperView: View {
    
    @Binding var showHelperView: Bool
    
    var body: some View {
        // swiftlint:disable closure_body_length
        VStack(alignment: .center){
            HStack {
                Spacer()
                    .frame(width: 340)
                Button(
                    action: {
                        showHelperView = false
                    },
                    label: {
                        Image("XButton")
                            .padding()
                    }
                )
                .padding(.trailing, 10)
            }
            
                Text("병아리의 스트레스 지수")
                    .font(.custom("DOSSaemmul", size: 20))
            
            
            // MARK: Happy Chick
            HStack{
                Image("Happy")
                    .resizable()
                    .frame(width: 91, height: 91)
                
                VStack(alignment: .leading){
                    Text("기분 체고!")
                        .font(.custom("DOSSaemmul", size: 16))
                    Image("HappyBar")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("0~20%")
                        .font(.custom("DOSSaemmul", size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 77, bottom: 0, trailing: 0))
            
            // MARK: Base Chick,
            HStack{
                Image("Normal")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("나쁘지 않아")
                        .font(.custom("DOSSaemmul", size: 16))
                    Image("NormalBar")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("20~40%")
                        .font(.custom("DOSSaemmul", size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 77, bottom: 0, trailing: 0))
            
            // MARK: Sad Chick
            HStack{
                Image("Sad")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("고만 좀 만져라..")
                        .font(.custom("DOSSaemmul", size: 16))
                    Image("SadBar")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("40~60%")
                        .font(.custom("DOSSaemmul", size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 77, bottom: 0, trailing: 0))
            
            // MARK: SoSad Chick
            HStack{
                Image("SoSad")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("살려조라ㅠ")
                        .font(.custom("DOSSaemmul", size: 16))
                    Image("SoSadBar")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("60~80%")
                        .font(.custom("DOSSaemmul", size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 77, bottom: 0, trailing: 0))
            
            // MARK: Angry Chick
            HStack{
                Image("Angry")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("%$#^&@!")
                        .font(.custom("DOSSaemmul", size: 16))
                    Image("AngryBar")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("80~100%")
                        .font(.custom("DOSSaemmul", size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 77, bottom: 0, trailing: 0))
            
            // MARK: GoOut Chick
            HStack{
                Image("GoOut")
                    .resizable()
                    .frame(width: 91, height: 91)
                VStack(alignment: .leading){
                    Text("%$#^&@!")
                        .font(.custom("DOSSaemmul", size: 16))
                    Image("GoOutBar")
                        .resizable()
                        .frame(width: 80, height: 8)
                    Text("100~1??%")
                        .font(.custom("DOSSaemmul", size: 12))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 77, bottom: 0, trailing: 0))
            
        }   // VStack
    }
}

//struct HelperView_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        HelperView(showHelperView: $showHelperView)
//    }
//}

