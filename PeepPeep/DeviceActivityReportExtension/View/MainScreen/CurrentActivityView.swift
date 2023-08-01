//
//  CurrentActivityView.swift
//  DeviceActivityReportExtension
//
//  Created by Ha Jong Myeong on 2023/08/01.
//

import FamilyControls
import PeepPeepCommons
import SwiftUI

struct CurrentActivityView: View {
    var activityReport: ActivityReport

    var body: some View {
        VStack {
            if activityReport.totalDuration <= 300 {
                EmptyActivityView()
            }
            else {
                CurrentActivitySummaryView(activityReport: activityReport)
            }
        }
    }
}

struct CurrentActivitySummaryView: View {
    var activityReport: ActivityReport

    /// PieChartView에서 사용할 차트 데이터를 반환
    var chartData: [(Double, Color)] {
        activityReport.apps.enumerated().map { (index, app) in
            (Double(app.duration), pieChartColorPalette[index % pieChartColorPalette.count])
        }
    }

    var body: some View {
        // 파이 차트 뷰와 총 활동 시간을 보여주는 텍스트 뷰를 중첩
        ZStack {
            PieChartView(data: chartData)
            TotalDurationText(duration: activityReport.totalDuration, text: "오늘 총 사용시간")
        }
        // 앱 별 Activity 리스트
        ActivityList(activities: activityReport.apps)
    }
}
