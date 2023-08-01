//
//  DiaryActivityView.swift
//  DeviceActivityReportExtension
//
//  Created by Youngbin Choi on 2023/07/27.
//

import Foundation
import SwiftUI

struct DiaryActivityView: View {
    @State var dateBeforeDownload: Bool = false
    @State var downloadedDate: String = ""
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
            if dateBeforeDownload {
//                Text("사용 시간")
//                    .font(.custom("DOSSaemmul", size: 14))
//                Text(formatter.string(from: mainActivity) ?? "0시간0분")
//                    .font(.custom("DOSSaemmul", size: 20))
//                    .padding(.top, 7)
                Text("병아리를\n만나기 전이에요")
                    .font(.custom("DOSSaemmul", size: 16))
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
            } else {
                Text("사용 시간")
                    .font(.custom("DOSSaemmul", size: 14))
                Text("0\(Int(mainActivity/3600.0)):\(Int(Int(mainActivity) % 3600)/60 < 10 ? "0\(Int(Int(mainActivity) % 3600)/60)" : "\(Int(Int(mainActivity) % 3600)/60)")")
                    .font(.custom("DOSSaemmul", size: 22))
                    .padding(.top, 7)
                Text("스트레스 지수")
                    .font(.custom("DOSSaemmul", size: 12))
                    .padding(.top, 25)
                Text("\(Int(CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 100))%")
                    .font(.custom("DOSSaemmul", size: 16))
                    .padding(.top, 5)
//                Text("테스트용 목표시간")
//                    .font(.custom("DOSSaemmul", size: 12))
//                Text("\(goalTime)")
//                    .font(.custom("DOSSaemmul", size: 12))
            }
        }
        .onAppear{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let today = dateFormatter.string(from: Date())
            clickedDate = UserDefaults.shared.string(forKey: "clickedDate") ?? today
            downloadedDate = UserDefaults.shared.string(forKey: "downloadedDate") ?? "2023.07.17"
            //클릭한 날짜를 다운로드한 날짜와 비교해서, 전자가 후자보다 빠르면 dateBeforeDownload 를 true로 바꾸어 코드를 분기
            if dateFormatter.date(from: clickedDate)?.compare((dateFormatter.date(from: downloadedDate) ?? dateFormatter.date(from: "2023.07.17"))!) == .orderedAscending {
                dateBeforeDownload = true
            } else{
                //달력에서 클릭한 날짜의 목표시간이 없다면, 이전 날짜를 하나씩 검사하며 가장 최근에 설정된 목표시간을 가져와 반영
                var dayCount = 0
                while (UserDefaults.shared.object(forKey: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: dayCount, to: dateFormatter.date(from: clickedDate)!)!)) == nil){
                    dayCount -= 1
                }
                goalTime = UserDefaults.shared.integer(forKey: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: dayCount, to: dateFormatter.date(from: clickedDate)!)!))
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
