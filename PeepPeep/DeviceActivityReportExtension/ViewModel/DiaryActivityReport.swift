//
//  DiaryActivityReport.swift
//  DeviceActivityReportExtension
//
//  Created by Youngbin Choi on 2023/07/27.
//

import Foundation

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let diaryActivity = Self("Diary Activity")
}

struct DiaryActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .diaryActivity
   
    
    // Define the custom configuration and the resulting view for this report.
    let content: (Double) -> DiaryActivityView
    
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
