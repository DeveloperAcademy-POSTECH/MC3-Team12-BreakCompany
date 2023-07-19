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
        if hours > 0 {
            return String(format: "%d hrs, %d min", hours, minutes)
        }
        else {
            return String(format: "%d min", minutes)
        }
    }
}
