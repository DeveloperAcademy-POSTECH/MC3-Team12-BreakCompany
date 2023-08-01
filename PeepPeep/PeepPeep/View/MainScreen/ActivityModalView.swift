//
//  ActivityModalView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/08/1.
//

import DeviceActivity
import FamilyControls
import PeepPeepCommons
import SwiftUI

struct ActivityModalView: View {
    @ObservedObject var model: ScreenTimeAppSelection
    @ObservedObject var viewModel: ScreenTimeAppSelectionViewModel
    @State var isPresented = false
    @State private var currentActivityContext: DeviceActivityReport.Context = .init(rawValue: "Current Activity")
    @State private var navigateToMain = false
    @Binding var showTotalActivity: Bool
    @State private var filter: DeviceActivityFilter = {
        // 오늘의 데이터를 가져오도록 설정
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)

        let todayInterval = DateInterval(start: startOfDay, end: endOfDay!)

        return DeviceActivityFilter(
            segment: .daily(during: todayInterval),
            users: .all,
            devices: .init([.iPhone, .iPad])
        )
    }()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 340)
                Button(
                    action: {
                        showTotalActivity = false
                    },
                    label: {
                        Image("XButton")
                            .padding()
                    }
                )
                .padding(.trailing, 10)
            }
            DeviceActivityReport(currentActivityContext, filter: filter)
        }
    }
}
