//
//  TotalActivityReport.swift
//  DeviceActuvityReportExtension
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
    // ActivityReport를 입력으로 받아 TotalActivityView를 반환하는 클로저
    let content: (ActivityReport) -> TotalActivityView

    /// 데이터를 ActivityReport로 변환합니다. 명시되는 호출 시점이 없이, TotalActivityReport 구조체가 사용되는 시점에서 암시적으로 호출 되고 있습니다.
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        let totalActivityDuration = await getTotalActivityDuration(from: data)
        let appActivities = await getAppDeviceActivities(from: data)
        return ActivityReport(totalDuration: totalActivityDuration, apps: appActivities)
    }

    /// 총 활동 시간 정보를 가져옵니다.
    private func getTotalActivityDuration(from data: DeviceActivityResults<DeviceActivityData>) async -> TimeInterval {
        await data.flatMap { $0.activitySegments }.reduce(0, { $0 + $1.totalActivityDuration })
    }

    /// 앱 별 활동 정보를 가져옵니다.
    private func getAppDeviceActivities(from data: DeviceActivityResults<DeviceActivityData>) async -> [AppDeviceActivity] {
        var appDeviceActivities: [AppDeviceActivity] = []
        for await dataItem in data {
            let activities = dataItem.activitySegments.flatMap { $0.categories }.flatMap { $0.applications }
            for await activity in activities where activity.totalActivityDuration > 300 {
                guard let appName = activity.application.localizedDisplayName,
                      let appToken = activity.application.token,
                      let bundle = activity.application.bundleIdentifier else {
                          continue
                      }
                let appDeviceActivity = AppDeviceActivity(id: bundle, displayName: appName, iconToken: appToken, duration: activity.totalActivityDuration)
                appDeviceActivities.append(appDeviceActivity)
            }
        }
        // 반환하는 과정에서 sorting, 5개 제한 수행
        return Array(appDeviceActivities.sorted(by: { $0.duration > $1.duration }).prefix(5))
    }
}
