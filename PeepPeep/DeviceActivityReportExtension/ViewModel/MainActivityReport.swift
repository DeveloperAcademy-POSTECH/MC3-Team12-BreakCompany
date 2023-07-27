//
//  MainActivityReport.swift
//  DeviceActivityReportExtension
//
//  Created by 이승용 on 2023/07/25.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let mainActivity = Self("Main Activity")
}

struct MainActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .mainActivity
   
    
    // Define the custom configuration and the resulting view for this report.
    let content: (Double) -> MainActivityView
    
//    let goalTime = CoreData.shared.getStoredDataFromCoreData()
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> Double {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.calendar?.locale = Locale(identifier: "ko_KR")
        
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        
//        return formatter.string(from: totalActivityDuration) ?? "No activity data"
        return totalActivityDuration
    }
}

