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
