//
//  ActivityReportModels.swift
//  DeviceActivityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/20.
//

import Foundation
import ManagedSettings
import SwiftUI

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
    var chartData: [(Double, Color)] {
        apps.enumerated().map { (index, app) in
            (Double(app.duration), ColorPalette[index % ColorPalette.count])
        }
    }
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var iconToken: ApplicationToken
    var duration: TimeInterval
    var color: Color {
        return ColorPalette[Int(id)! % ColorPalette.count]
    }
}

let ColorPalette: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
