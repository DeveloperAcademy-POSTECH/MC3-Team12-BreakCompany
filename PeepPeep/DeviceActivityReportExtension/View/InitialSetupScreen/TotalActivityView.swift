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

    var body: some View {
        VStack {
            PieChart(activityReport: activityReport)
            SelectionInstruction()
            AppActivityList(activityReport: activityReport)
        }
    }
}

/// 파이차트 뷰
struct PieChart: View {
    var activityReport: ActivityReport
    var body: some View {
        ZStack {
            PieChartView(data: activityReport.chartData)
            VStack {
                Text("어제 총 사용시간")
                    .font(.dosSsaemmul(size: 17))
                    .padding(.bottom, 3)
                Text("\(activityReport.totalDuration.stringFromTimeInterval())")
                    .font(.dosSsaemmul(size: 25))
            }
        }
    }
}

/// 햅 활동 정보 리스트 행
struct ListRow: View {
    var eachApp: AppDeviceActivity

    var body: some View {
        HStack {
            Rectangle()
                .fill(eachApp.color)
                .frame(width: 5, height: 10)
                .cornerRadius(5)
            Label(eachApp.iconToken).labelStyle(.iconOnly)
            Text(eachApp.displayName)
            Spacer()
            Text(eachApp.duration.stringFromTimeInterval())
        }
    }
}

/// 앱 선택 안내 문구
struct SelectionInstruction: View {
    var body: some View {
        Text("선택하기 버튼을 눌러\n사용 시간을 줄이고 싶은 앱을 선택해주세요")
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .font(.dosSsaemmul(size: 15))
    }
}

/// 앱 활동 정보 리스트
struct AppActivityList: View {
    var activityReport: ActivityReport

    var body: some View {
        List(activityReport.apps.indices, id: \.self) { index in
            ListRow(eachApp: activityReport.apps[index])
                .font(.dosSsaemmul(size: 17))
        }
        .background(.white)
        .scrollContentBackground(.hidden)
    }
}
