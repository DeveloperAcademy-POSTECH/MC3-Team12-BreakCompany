//
//  ActivitySummaryView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import DeviceActivity
import SwiftUI

struct ActivitySummaryView: View {
    @State private var totalActivityContext: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )

    var body: some View {
        ZStack {
            STProgressView()
            DeviceActivityReport(totalActivityContext, filter: filter)
        }
    }
}
