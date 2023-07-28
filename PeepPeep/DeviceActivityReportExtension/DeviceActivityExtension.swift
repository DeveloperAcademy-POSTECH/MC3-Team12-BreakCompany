//
//  DeviceActivityExtension.swift
//  DeviceActuvityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import DeviceActivity
import SwiftUI

@main
struct DeviceActivityExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(activityReport: totalActivity)
        }
        // Add more reports here...
        MainActivityReport { mainActivity in
            MainActivityView(mainActivity: mainActivity)
        }
    }
}

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.7C76V3X7AB.com.restco.PeepPeep"
        guard let defaults = UserDefaults(suiteName: appGroupId) else {
            fatalError("appGroup을 통한 UserDefault를 생성할 수 없습니다.")
        }
        return defaults
    }
}
