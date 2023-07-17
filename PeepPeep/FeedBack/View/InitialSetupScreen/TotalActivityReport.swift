//
//  TotalActivityReport.swift
//  FeedBack
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import DeviceActivity
import ManagedSettings
import SwiftUI

extension DeviceActivityReport.Context {
    static let totalActivity = Self("Total Activity")
}

struct TotalActivityReport: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .totalActivity
    let content: (ActivityReport) -> TotalActivityView // ActivityReport를 입력으로 받아 TotalActivityView를 반환하는 클로저

    // 데이터를 ActivityReport로 변환
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        let totalActivityDuration = await getTotalActivityDuration(from: data)
        let appActivities = await getAppDeviceActivities(from: data)
        return ActivityReport(totalDuration: totalActivityDuration, apps: appActivities)
    }

    // 총 활동 시간 정보 가져오기
    private func getTotalActivityDuration(from data: DeviceActivityResults<DeviceActivityData>) async -> TimeInterval {
        await data.flatMap { $0.activitySegments }.reduce(0, { $0 + $1.totalActivityDuration })
    }

    // 앱 별 활동 정보 가져오기
    private func getAppDeviceActivities(from data: DeviceActivityResults<DeviceActivityData>) async -> [AppDeviceActivity] {
        var appDeviceActivities: [AppDeviceActivity] = []
        for await dataItem in data {
            let activities = dataItem.activitySegments.flatMap { $0.categories }.flatMap { $0.applications }
            for await activity in activities where activity.totalActivityDuration > 300 {
                let appName = activity.application.localizedDisplayName ?? "nil"
                let appToken = activity.application.token ?? nil
                let bundle = activity.application.bundleIdentifier ?? "nil"
                let appDeviceActivity = AppDeviceActivity(id: bundle, displayName: appName, iconToken: appToken!, duration: activity.totalActivityDuration)
                appDeviceActivities.append(appDeviceActivity)
            }
        }
        return appDeviceActivities
    }
}

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var iconToken: ApplicationToken
    var duration: TimeInterval
}
