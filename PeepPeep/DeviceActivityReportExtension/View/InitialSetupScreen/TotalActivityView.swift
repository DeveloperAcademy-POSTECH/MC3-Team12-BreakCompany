//
//  TotalActivityView.swift
//  DevuceActuvityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import SwiftUI
import FamilyControls
import PeepPeepCommons

struct TotalActivityView: View {
    var activityReport: ActivityReport
    
    /// PieChartView에서 사용할 차트 데이터를 반환합니다
    var chartData: [(Double, Color)] {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
        return activityReport.apps.enumerated().map { (index, app) in
            (Double(app.duration), colors[index % colors.count])
        }
    }
    
    var body: some View {
        VStack {
            // 파이 차트 뷰와 총 활동 시간을 보여주는 텍스트 뷰를 중첩
            ZStack {
                PieChartView(data: chartData)
                Text(activityReport.totalDuration.stringFromTimeInterval())
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            // 앱 별 Activity 리스트
            List(activityReport.apps) { app in
                ListRow(eachApp: app)
            }
        }
    }
}

struct ListRow: View {
    var eachApp: AppDeviceActivity
    var body: some View {
        HStack {
            Label(eachApp.iconToken).labelStyle(.iconOnly)
            Text(eachApp.displayName)
            Spacer()
            Text(eachApp.duration.stringFromTimeInterval())
        }
    }
}

struct PieChartView: View {
    /// 차트 데이터에 해당합니다.
    let data: [(Double, Color)]
    
    var body: some View {
        GeometryReader { geometry in
            let diameter = min(geometry.size.width, geometry.size.height) * 0.7
            
            ZStack {
                Canvas { context, size in
                    drawPieSlice(context: context, size: size)
                }
                .aspectRatio(1, contentMode: .fit)
                Circle()
                    .fill(Color.white)
                    .frame(width: diameter, height: diameter, alignment: .center)
            }
        }
    }
    
    /// 중심을 기준으로 반지름에 따른 원을 그리고, 각각의 파이 슬라이스를 색상에 맞게 채웁니다.
    private func drawPieSlice(context: GraphicsContext, size: CGSize) {
        let total = data.reduce(0) { $0 + $1.0 }
        let radius = min(size.width, size.height) * 0.4
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        var startAngle = Angle.zero
        for (value, color) in data {
            let angle = Angle(degrees: 360 * (value / total))
            let endAngle = startAngle + angle
            let path = Path { path in
                path.move(to: center)
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                path.closeSubpath()
            }
            context.fill(path, with: .color(color))
            startAngle = endAngle
        }
    }
}
