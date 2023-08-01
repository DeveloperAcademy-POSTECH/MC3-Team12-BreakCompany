//
//  InitialTimeSettingView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/08/1.
//

import DeviceActivity
import PeepPeepCommons
import SwiftUI

struct InitialTimeSettingView: View {
    let hours = Array(0...23)
    let minutes = [0, 10, 20, 30, 40, 50]
    @State var selectedHours = 4
    @State var selectedMinutes = 0
    @State var goalTime: Int = 240

    var body: some View {
        VStack {
            ProgressBar(currentStep: 4)
            Spacer()
            CustomSpacer(height: 80)
            TitleView()
            CustomSpacer(height: 20)
            TimePickersView(selectedHours: $selectedHours, selectedMinutes: $selectedMinutes, hours: hours, minutes: minutes)
            CustomSpacer(height: 130)
            DecisionButtonView(setGoalTime: setGoalTime)
            CustomSpacer(height: 20)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(), trailing: SkiptoMainButton(setGoalTime: setGoalTime))
    }

    // 목표 시간을 설정하고 저장
    private func setGoalTime() {
        let goalTime = hours[hours.firstIndex(of: selectedHours) ?? 0]*60 + minutes[minutes.firstIndex(of: selectedMinutes) ?? 0]
        let settedDay = getFormattedDate(from: Date())
        UserDefaults.shared.set(goalTime, forKey: settedDay)
    }

    // 현재 날짜를 "yyyy.MM.dd" 형식의 문자열로 변환
    private func getFormattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}

// 타이틀 뷰
struct TitleView: View {
    var body: some View {
        Text("핸드폰 목표 사용 시간 설정")
            .font(.dosSsaemmul(size: 17))
            .padding(.vertical, 20)
    }
}

// 시간 선택 뷰
struct TimePickersView: View {
    @Binding var selectedHours: Int
    @Binding var selectedMinutes: Int
    let hours: [Int]
    let minutes: [Int]

    var body: some View {
        HStack {
            PickerComponentView(selection: $selectedHours, items: hours)
            Text("Hours").font(.dosSsaemmul(size: 20))
            PickerComponentView(selection: $selectedMinutes, items: minutes)
            Text("Mins").font(.dosSsaemmul(size: 20))
        }
        .frame(width: 318, height: 254, alignment: .center)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
        }
        .padding(.vertical, 20)
    }
}

// 타임 피커 컴포넌트 뷰
struct PickerComponentView: View {
    @Binding var selection: Int
    let items: [Int]

    var body: some View {
        Picker("", selection: $selection) {
            ForEach(items, id: \.self) { item in
                Text("\(item)").font(.dosSsaemmul(size: 20))
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 80)
    }
}

// 결정 버튼
struct DecisionButtonView: View {
    let setGoalTime: () -> Void
    @State private var navigateToMain = false

    var body: some View {
        VStack {
            NavigationLink("", destination: MainView(), isActive: $navigateToMain)
            Button(action: {
                setGoalTime()
                navigateToMain = true
                checkSetupComplete()
            }) {
                Text("결정")
                    .frame(width: 106, height: 44)
                    .font(.dosSsaemmul(size: 20))
                    .foregroundColor(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.black, lineWidth: 1)
                    }
            }
            .padding(.vertical, 20)
        }
    }

    private func checkSetupComplete() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        UserDefaults.shared.set(dateFormatter.string(from: Date()), forKey: "downloadedDate")
        UserDefaults.shared.set(true, forKey: "initialSetupComplete")
    }
}

// 스킵 버튼
struct SkiptoMainButton: View {
    @State private var navigateToMain = false
    let setGoalTime: () -> Void

    var body: some View {
        NavigationLink {
            MainView()
        } label: {
            Text("Skip")
                .font(.dosSsaemmul(size: 20))
        }
        .simultaneousGesture(TapGesture().onEnded({ _ in
            // 스킵하면 기본값 4시간으로 시간 세팅
            navigateToMain = true
            setGoalTime()
        }))
    }
}

struct InitialTimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTimeSettingView()
    }
}
