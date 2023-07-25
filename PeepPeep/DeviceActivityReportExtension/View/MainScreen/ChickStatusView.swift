//
//  ProgressBarView.swift
//  DeviceActivityReportExtension
//
//  Created by 이승용 on 2023/07/25.
//

import SwiftUI

struct ChickStatusView: View {
//    let lightGreen = Color("LightGreen")
    var currentUsageTime: CGFloat = 217  // minutes, 사용시간
    var targetUsageTime: CGFloat = 240   // minutes, 목표시간
    var color: [Color] = [.green, .yellow, .orange, .red]
    
    var body: some View {
        //        Text("Progress Bar View")
        
        VStack{
            // 현재 사용 시간 Text
            // TODO: ScreenTime data parsing 해서 시간 보여주기
            
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .frame(width: 106, height: 24)
                    .overlay{
                        // Border of progress bar RoundedRectangle
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black)
                    }
                    .overlay(alignment: .leading){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.red)
                            .frame(width: (currentUsageTime / targetUsageTime * 106))
                    }
                
                Text("88%")
                    .foregroundColor(.white)
            }   // ZStack
            
            // 병아리 정보
            //            VStack{
            //                Image("Angry 1")
            //                    .resizable()
            //                    .frame(width: 180, height: 180)
            //
            //                Text("Lv.1")
            //                    .font(.system(size: 13))
            //
            //                Text("병아리 너무 귀여워")
            //                    .font(.system(size: 20))
            //                    .padding()
            //            }
        }   // VStack
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChickStatusView()
    }
}

