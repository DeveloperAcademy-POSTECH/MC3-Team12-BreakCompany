//
//  TotalActivityView.swift
//  DeviceActuvityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import FamilyControls
import PeepPeepCommons
import SwiftUI

struct TotalActivityView: View {
    var activityReport: ActivityReport
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]

    /// PieChartView에서 사용할 차트 데이터를 반환합니다
    var chartData: [(Double, Color)] {
        activityReport.apps.enumerated().map { (index, app) in
            (Double(app.duration), colors[index % colors.count])
        }
    }

    var body: some View {
        VStack {
            // 파이 차트 뷰와 총 활동 시간을 보여주는 텍스트 뷰를 중첩
            Text("오늘, 이만큼 휴대폰을 사용했네요!")
                .font(.dosSsaemmul(size: 20))

            ZStack {
                PieChartView(data: chartData)
                Text("Total\n\(activityReport.totalDuration.stringFromTimeInterval())")
                    .font(.dosSsaemmul(size: 24))
                    .multilineTextAlignment(.center)
            }

            // 앱 별 Activity 리스트
            List(activityReport.apps.indices, id: \.self) { index in
                ListRow(eachApp: activityReport.apps[index], color: colors[index % colors.count])
            }
            .background(.white)
            .scrollContentBackground(.hidden)
        }
    }
}

struct ListRow: View {
    var eachApp: AppDeviceActivity
    var color: Color
    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 5, height: 10)
                .cornerRadius(5)
            Label(eachApp.iconToken).labelStyle(.iconOnly)
            Text(eachApp.displayName)
            Spacer()
            Text(eachApp.duration.stringFromTimeInterval())
        }
    }
}
