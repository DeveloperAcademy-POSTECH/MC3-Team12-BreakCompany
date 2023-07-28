//
//  DiaryActivityView.swift
//  DeviceActivityReportExtension
//
//  Created by Youngbin Choi on 2023/07/27.
//

import Foundation
import SwiftUI

struct DiaryActivityView: View {
    @State var clickedDate: String = ""
    @State var goalTime: Int = 480
    let mainActivity : Double
    var color: [Color] = [Color("LightGreen"), .green, .yellow, .orange, .red]
    let formatter: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
            formatter.unitsStyle = .abbreviated
            formatter.zeroFormattingBehavior = .dropAll
            formatter.calendar?.locale = Locale(identifier: "ko_KR")
            return formatter
        }()
    
    var body: some View {
        VStack {
            Text("사용 시간")
                .font(.custom("DOSSaemmul", size: 11))
            Text(formatter.string(from: mainActivity) ?? "0시간0분")
                .font(.custom("DOSSaemmul", size: 20))
                .padding(.top, 7)
            Text("스트레스 지수")
                .font(.custom("DOSSaemmul", size: 12))
                .padding(.top, 30)
            Text("\(Int(CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 100))%")
                .font(.custom("DOSSaemmul", size: 16))
                .padding(.top, 7)
        }
        .onAppear{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let today = dateFormatter.string(from: Date())
            clickedDate = UserDefaults.shared.string(forKey: "clickedDate") ?? today
            //목표설정시간이 없는 날은 목표시간을 240분으로 임의로 설정한다
            if UserDefaults.shared.object(forKey: clickedDate) == nil {
                goalTime = 240
            } else {
                goalTime = UserDefaults.shared.integer(forKey: clickedDate)
            }
        }
    }
}
extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let red = Double((rgb >> 16) & 0xFF) / 255.0
    let green = Double((rgb >>  8) & 0xFF) / 255.0
    let blue = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: red, green: green, blue: blue)
  }
}
