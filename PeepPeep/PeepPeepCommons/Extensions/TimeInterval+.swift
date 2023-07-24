//
//  TimeInterval+.swift
//  PeepPeepCommons
//
//  Created by Ha Jong Myeong on 2023/07/19.
//

import Foundation

/// TimeInterval을 시간 문자열로 변환하는 extension
public extension TimeInterval {
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return hours > 0 ? String(format: "%d hrs, %d min", hours, minutes) : String(format: "%d min", minutes)
    }
}
