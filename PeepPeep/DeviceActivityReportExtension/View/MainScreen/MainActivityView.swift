//
//  MainActivityView.swift
//  DeviceActivityReportExtension
//
//  Created by 이승용 on 2023/07/25.
//

import SwiftUI

struct MainActivityView: View {
    @State private var currentTime = Date()
    let goalTime: Int = 480
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
            Text("현재 사용 시간")
                .font(.custom("DOSSaemmul", size: 17))
            Text("0\(Int(mainActivity/3600.0)):\(Int(Int(mainActivity) % 3600)/60 < 10 ? "0\(Int(Int(mainActivity) % 3600)/60)" : "\(Int(Int(mainActivity) % 3600)/60)")")
                .font(.custom("DOSSaemmul", size: 36))
                .padding(.top, 7)
            Text("스트레스 지수")
                .font(.custom("DOSSaemmul", size: 16))
                .padding(.top, 30)
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .frame(width: 106, height: 24)
                    .overlay{
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black)
                    }
                    .overlay(alignment: .leading){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(statusColor(stress: Int(CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 100)))
                            .frame(width: (CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 106))
                    }

                Text("\(Int(CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 100))%")
                    .font(.custom("DOSSaemmul", size: 17))
                    .foregroundColor(.black)
                
            }
            //현재시간이 자정부터 오전 8시 사이면 자는 병아리이미지, 그 외에는 일반이미지
            if isWithinRange() {
                Image("Sleep2")
                    .resizable()
                    .frame(width: 250, height: 250, alignment: .center)
            } else {
                chickImage(stress: Int(CGFloat(Int(mainActivity/60.0)) / CGFloat(goalTime) * 100))
                    .resizable()
                    .frame(width: 250, height: 250, alignment: .center)
                Text("Lv. 1")
                    .font(.custom("DOSSaemmul", size: 13))
                Text("병만이")
                    .font(.custom("DOSSaemmul", size: 20))
                    .padding(.top, 3)
            }
            
        }
        //60초 마다 현재 시간을 업데이트
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            self.currentTime = Date()
        }
    }
    private func isWithinRange() -> Bool {
            let calendar = Calendar.current
            let currentHour = calendar.component(.hour, from: currentTime)
            return currentHour >= 0 && currentHour < 8
        }
}
func chickImage(stress: Int) -> Image {
    switch stress {
    case 0 ..< 20 :
        return Image("Happy")
    case 20 ..< 40 :
        return Image("Normal")
    case 40 ..< 60 :
        return Image("Sad")
    case 60 ..< 80 :
        return Image("SoSad")
    case 80 ..< 100 :
        return Image("Angry")
    case 100 ..< 1000 :
        return Image("Bye")
    default:
        return Image("Normal")
    }
}
func statusColor(stress: Int) -> Color {
    let color: [Color] = [Color("LightGreen"), .green, .yellow, .orange, .red]
    switch stress {
    case 0 ..< 20 :
        return color[0]
    case 20 ..< 40 :
        return color[1]
    case 40 ..< 60 :
        return color[2]
    case 60 ..< 80 :
        return color[3]
    case 80 ..< 100 :
        return color[4]
    default:
        return color[1]
    }
}

