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
    @State var isPresented = false
    @State private var totalActivityContext: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var navigateToMain = false
    @State private var filter: DeviceActivityFilter = {
        // 현재 날짜를 불러올 수 없다면, 이전 24시간의 기준으로 날짜의 사용시간 데이터를 받아올 수 있도록 설정
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? now
        let dateInterval = DateInterval(start: startOfDay, end: endOfDay)
        return DeviceActivityFilter(
            segment: .daily(during: dateInterval),
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
                    navigateToMain = true
                    viewModel.saveSelection(selection: model.activitySelection)
                }
            NavigationLink(destination: MainView(), isActive: $navigateToMain) {
            }
            CustomSpacer(height: 30)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
        .foregroundColor(Color.black)
    }
}

struct ActivitySummaryView_Previews: PreviewProvider {
    @ObservedObject var model: ScreenTimeAppSelection
    @ObservedObject var viewModel: ScreenTimeAppSelectionViewModel
    static var previews: some View {
        ActivitySummaryView(model: ScreenTimeAppSelection(), viewModel: ScreenTimeAppSelectionViewModel())
    }
}
