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
    @EnvironmentObject var model: ScreenTimeAppSelection
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
            CustomSpacer(height: 30)
            Text("오늘, 이만큼 휴대폰을 사용했어요!")
                .font(.dosSsaemmul(size: 20))
                .padding(.bottom, 5)
            DeviceActivityReport(totalActivityContext, filter: filter)
            Button("확인") { isPresented = true }
                .buttonStyle(CommonButtonStyle(paddingSize: 30))
                .familyActivityPicker(isPresented: $isPresented, selection: $model.newSelection)
                .onChange(of: model.newSelection) { _ in
                    navigateToMain = true
                }
                NavigationLink(destination: MainView(), isActive: $navigateToMain) {
                    EmptyView()
                }
            CustomSpacer(height: 30)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
        .foregroundColor(Color.black)
    }
}
