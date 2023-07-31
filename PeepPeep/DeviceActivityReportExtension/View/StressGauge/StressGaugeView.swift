//
//  StressGaugeView.swift
//  DeviceActivityReportExtension
//
//  Created by 예슬 on 2023/07/31.
//

import SwiftUI

struct StressGaugeView: View {
    
    @State var goalTime: Int
    @State var mainActivity : Double
    let gaugeWidth : CGFloat = 102
    private var percentString: String {
        print("@LOG \(mainActivity)")
        return "\(Int(CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 100))%"
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: 106, height: 24.4)
                .overlay{
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black)
                }
            // 스트레스 게이지 바
                .overlay(alignment: .leading){
                    RoundedRectangle(cornerRadius: 3)
                        .fill(statusColor(stress: Int(CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 100)))
                        .frame(width: ((CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * gaugeWidth) > CGFloat(gaugeWidth) ? CGFloat(gaugeWidth) : CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * gaugeWidth), height: 19.26)
                        .padding(.leading, 2.4)
                }
            // 스트레스 퍼센트
            Text(percentString)
                .font(.custom("DOSSaemmul", size: 17))
                .foregroundColor(.black)
            
        }
    }
}
//
//struct previewStrss: PreviewProvider {
//    static var previews: some View {
//        //StressGaugeView(goalTime: 30, mainActivity: 1400)
//    }
//}
