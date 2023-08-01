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
    @State var testGoalTime = 0

    var body: some View {
        VStack {
            TitleView()
            TimePickersView(selectedHours: $selectedHours, selectedMinutes: $selectedMinutes, hours: hours, minutes: minutes)
            DecisionButtonView(setGoalTime: setGoalTime)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
    }

    // 목표 시간을 설정하고 저장
    private func setGoalTime() {
        let goalTime = hours[selectedHours] * 60 + minutes[selectedMinutes]
        let settedDay = getFormattedDate(from: Date())
        UserDefaults.shared.set(goalTime, forKey: settedDay)
        testGoalTime = UserDefaults.shared.integer(forKey: settedDay)
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
            .font(.custom("DOSSaemmul", size: 17))
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
            Text("Hours").font(.custom("DOSSaemmul", size: 20))
            PickerComponentView(selection: $selectedMinutes, items: minutes)
            Text("Mins").font(.custom("DOSSaemmul", size: 20))
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
                Text("\(item)").font(.custom("DOSSaemmul", size: 20))
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
            }) {
                Text("결정")
                    .frame(width: 106, height: 44)
                    .font(.custom("DOSSaemmul", size: 20))
                    .foregroundColor(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black, lineWidth: 1)
                    }
            }
            .padding(.vertical, 20)
        }
    }
}
