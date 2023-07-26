//
//  ActivityReportModels.swift
//  DeviceActivityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/20.
//

import Foundation
import ManagedSettings

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
