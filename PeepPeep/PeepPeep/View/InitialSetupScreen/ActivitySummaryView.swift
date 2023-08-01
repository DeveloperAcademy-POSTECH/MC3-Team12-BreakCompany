//
//  ActivitySummaryView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import DeviceActivity
import FamilyControls
import PeepPeepCommons
import SwiftUI

struct ActivitySummaryView: View {
    @ObservedObject var model: ScreenTimeAppSelection
    @ObservedObject var viewModel: ScreenTimeAppSelectionViewModel
    @State private var isPresented = false
    @State private var totalActivityContext: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var navigateToInitialTimeSetting = false
    @State private var filter: DeviceActivityFilter = {
        // 이전날의 데이터를 받아올 수 없다면, 이틀 전의 데이터를 받아올 수 있도록 설정
        let dateIntervals: [DateInterval] = (1...2).compactMap { daysAgo -> DateInterval? in
            let now = Date()
            guard let startOfDay = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Calendar.current.startOfDay(for: now)),
                  let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) else {
                return nil
            }
            return DateInterval(start: startOfDay, end: endOfDay)
        }
        let previousDayInterval = dateIntervals.first

        return DeviceActivityFilter(
            segment: .daily(during: previousDayInterval ?? DateInterval()),
            users: .all,
            devices: .init([.iPhone, .iPad])
        )
    }()

    var body: some View {
        VStack {
            ProgressBar(currentStep: 3)
            DeviceActivityReport(totalActivityContext, filter: filter)
            Button("선택하기") { isPresented = true }
                .buttonStyle(CommonButtonStyle(paddingSize: 20))
                .familyActivityPicker(isPresented: $isPresented, selection: $model.activitySelection)
                .onChange(of: model.activitySelection) { _ in
                    navigateToInitialTimeSetting = true
                    viewModel.saveSelection(selection: model.activitySelection)
                }
            NavigationLink(destination: InitialTimeSettingView(), isActive: $navigateToInitialTimeSetting) {
            }
            CustomSpacer(height: 35)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
    }
}

struct ActivitySummaryView_Previews: PreviewProvider {
    @ObservedObject var model: ScreenTimeAppSelection
    @ObservedObject var viewModel: ScreenTimeAppSelectionViewModel
    static var previews: some View {
        ActivitySummaryView(model: ScreenTimeAppSelection(), viewModel: ScreenTimeAppSelectionViewModel())
    }
}
