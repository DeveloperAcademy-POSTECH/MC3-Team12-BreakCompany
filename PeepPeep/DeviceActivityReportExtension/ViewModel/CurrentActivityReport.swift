//
//  CurrentActivityReport.swift
//  DeviceActivityReportExtension
//
//  Created by Ha Jong Myeong on 2023/08/01.
//

import DeviceActivity
import FamilyControls
import ManagedSettings
import SwiftUI

extension DeviceActivityReport.Context {
    static let currentActivity = Self("Current Activity")
}

struct CurrentActivityReport: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .currentActivity
    // ActivityReport를 입력으로 받아 CurrentActivityView를 반환하는 클로저
    let content: (ActivityReport) -> CurrentActivityView

    /// 데이터를 ActivityReport로 변환합니다. 명시되는 호출 시점이 없이, CurrentActivityReport 구조체가 사용되는 시점에서 암시적으로 호출 되고 있습니다.
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        let totalActivityDuration = await getTotalActivityDuration(from: data)
        let appActivities = await getAppDeviceActivities(from: data)
        return ActivityReport(totalDuration: totalActivityDuration, apps: appActivities)
    }

    /// 총 활동 시간 정보를 가져옵니다.
    private func getTotalActivityDuration(from data: DeviceActivityResults<DeviceActivityData>) async -> TimeInterval {
        var totalDuration: TimeInterval = 0

        // 선택한 앱 활동시간 합
        for await dataItem in data {
            let activities = dataItem.activitySegments.flatMap { $0.categories }.flatMap { $0.applications }
            for await activity in activities where activity.totalActivityDuration > 300 {
                guard let token = activity.application.token,
                      let selection = loadActivitySelection(),
                      selection.applicationTokens.contains(token)
                else {
                    continue
                }
                totalDuration += activity.totalActivityDuration
            }
        }

        // 선택한 카테고리 활동시간 합
        for await dataItem in data {
            let activities = dataItem.activitySegments.flatMap { $0.categories }
            for await activity in activities where activity.totalActivityDuration > 300 {
                guard let token = activity.category.token,
                      let selection = loadActivitySelection(),
                      selection.categoryTokens.contains(token)
                else {
                    continue
                }
                totalDuration += activity.totalActivityDuration
            }
        }
        return totalDuration
    }

    /// 앱 별 활동 정보를 가져옵니다.
    private func getAppDeviceActivities(from data: DeviceActivityResults<DeviceActivityData>) async -> [AppDeviceActivity] {
        var appDeviceActivities: [AppDeviceActivity] = []

        // 선택한 앱에 해당하는 활동 정보 append
        for await dataItem in data {
            let activities = dataItem.activitySegments.flatMap { $0.categories }.flatMap { $0.applications }
            for await activity in activities where activity.totalActivityDuration > 300 {
                guard let appName = activity.application.localizedDisplayName,
                      let appToken = activity.application.token,
                      let bundle = activity.application.bundleIdentifier,
                      let selection = loadActivitySelection(),
                      selection.applicationTokens.contains(appToken)
                else {
                    continue
                }
                let appDeviceActivity = AppDeviceActivity(id: bundle, displayName: appName, iconToken: appToken, duration: activity.totalActivityDuration)
                appDeviceActivities.append(appDeviceActivity)
            }
        }

        // 선택한 카테고리에 해당하는 앱의 활동 정보 append
        for await dataItem in data {
            let activities = dataItem.activitySegments.flatMap { $0.categories }
            for await activity in activities where activity.totalActivityDuration > 300 {
                guard let token = activity.category.token,
                      let selection = loadActivitySelection(),
                      selection.categoryTokens.contains(token)
                else {
                    continue
                }
                let appActivities = activities.flatMap {$0.applications}
                for await activity in appActivities where
                activity.totalActivityDuration > 300 {
                    guard let appName =  activity.application.localizedDisplayName,
                          let appToken = activity.application.token,
                          let bundle = activity.application.bundleIdentifier,
                          // append 전 bundle Id 값 체크로 중복 체크
                          !appDeviceActivities.contains(where: {$0.id == bundle})
                    else {
                        continue
                    }
                    let appDeviceActivity = AppDeviceActivity(id: bundle, displayName: appName, iconToken: appToken, duration: activity.totalActivityDuration)
                    appDeviceActivities.append(appDeviceActivity)
                }
            }
        }

        return appDeviceActivities.sorted(by: { $0.duration > $1.duration })
    }

    /// UserDefaults에 저장된 ScreenTimeSelection 데이터 decode 후, fetch
    private func loadActivitySelection() -> FamilyActivitySelection? {
        let defaults = UserDefaults.shared
        guard let data = defaults.data(forKey: "ScreenTimeSelection") else {
            return nil
        }

        let decoder = PropertyListDecoder()
        return try? decoder.decode(FamilyActivitySelection.self, from: data)
    }
}
