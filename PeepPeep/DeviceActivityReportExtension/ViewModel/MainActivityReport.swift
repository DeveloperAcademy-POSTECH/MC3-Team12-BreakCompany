//
//  MainActivityReport.swift
//  DeviceActivityReportExtension
//
//  Created by 이승용 on 2023/07/25.
//

import DeviceActivity
import SwiftUI
import ManagedSettings
import FamilyControls
import PeepPeepCommons

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let MainActivity = Self("Main Activity")
}

struct MainActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .MainActivity

    // Define the custom configuration and the resulting view for this report.
    let content: (String) -> MainActivityView

    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> String {
        let selectedAppsActivityDuration = await calculateSelectedAppsActivityDuration(from: data)
        return formatTimeInterval(selectedAppsActivityDuration) ?? "No activity data"
    }

    /// 앱 토큰을 UserDefaults에 저장된 앱 토큰과 비교해 선택한 앱들의 총 활동 시간의 합을 반환.
    private func calculateSelectedAppsActivityDuration(from data: DeviceActivityResults<DeviceActivityData>) async -> TimeInterval {
        var calculatedDuration: TimeInterval = 0

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
                calculatedDuration += activity.totalActivityDuration
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
                calculatedDuration += activity.totalActivityDuration
            }
        }
        return calculatedDuration
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
