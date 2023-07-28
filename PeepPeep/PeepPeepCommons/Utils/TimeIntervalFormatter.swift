//
//  TimeIntervalFormatter.swift
//  PeepPeepCommons
//
//  Created by Ha Jong Myeong on 2023/07/28.
//

import Foundation

// TimeInterval Formatter
public func formatTimeInterval(_ timeInterval: TimeInterval) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.day, .hour, .minute]
    formatter.unitsStyle = .abbreviated
    formatter.zeroFormattingBehavior = .dropAll
    formatter.calendar?.locale = Locale(identifier: "ko_KR")

    return formatter.string(from: timeInterval)
}
