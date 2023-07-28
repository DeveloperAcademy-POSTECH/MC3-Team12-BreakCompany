//  TotalActivityView.swift
//  DeviceActivityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import FamilyControls
import PeepPeepCommons
import SwiftUI

struct TotalActivityView: View {
    var activityReport: ActivityReport

    /// PieChartView에서 사용할 차트 데이터를 반환
    var chartData: [(Double, Color)] {
        activityReport.apps.enumerated().map { (index, app) in
            (Double(app.duration), pieChartColorPalette[index % pieChartColorPalette.count])
        }
    }

    var body: some View {
        VStack {
            // 파이 차트 뷰와 총 활동 시간을 보여주는 텍스트 뷰를 중첩
            ZStack {
                PieChartView(data: chartData)
                TotalDurationText(duration: activityReport.totalDuration)
            }
            InstructionText()
            // 앱 별 Activity 리스트
            ActivityList(activities: activityReport.apps)
        }
    }
}

/// 총 사용 시간
struct TotalDurationText: View {
    var duration: TimeInterval

    var body: some View {
        VStack {
            Text("어제 총 사용시간")
                .padding(.bottom, 3)
                .font(.dosSsaemmul(size: 17))
            Text("\(duration.stringFromTimeInterval())")
                .font(.dosSsaemmul(size: 20))
        }
    }
}

/// 안내 문구
struct InstructionText: View {
    var body: some View {
        Text("선택하기 버튼을 눌러\n사용 시간을 줄이고 싶은 앱을 선택해주세요")
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .font(.dosSsaemmul(size: 17))
    }
}

/// 앱 Activity 리스트
struct ActivityList: View {
    var activities: [AppDeviceActivity]

    var body: some View {
        List(activities.indices, id: \.self) { index in
            ActivityRow(eachApp: activities[index], color: pieChartColorPalette[index % pieChartColorPalette.count])
        }
        .background(.white)
        .scrollContentBackground(.hidden)
    }
}

/// 앱 Activity 리스트 상세(행)
struct ActivityRow: View {
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
                .font(.dosSsaemmul(size: 17))
            Spacer()
            Text(eachApp.duration.stringFromTimeInterval())
                .font(.dosSsaemmul(size: 17))
        }
    }
}
