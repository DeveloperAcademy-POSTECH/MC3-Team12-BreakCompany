//
//  TimeSettingView.swift
//  PeepPeep
//
//  Created by 이승용 on 2023/07/26.
//

import SwiftUI
import DeviceActivity

struct TimeSettingView: View {
    let hours = Array(0...23)
    let minutes = [0, 10, 20, 30, 40, 50]
    @State var selectedHours = 4
    @State var selectedMinutes = 0
    @State var testGoalTime = 0
    
    var body: some View {
        VStack {
            Text("핸드폰 목표 사용 시간 설정")
                .font(.custom("DOSSaemmul", size: 17))
                .padding(.vertical, 20)
            Text("하루에 한번만 설정을 바꿀 수 있습니다")
                .font(.custom("DOSSaemmul", size: 13))
                .padding(.vertical, 20)
            HStack {
                Picker("hourPicker", selection: $selectedHours) {
                    ForEach(hours, id: \.self) { hour in
                        Text("\(hour)")
                            .font(.custom("DOSSaemmul", size: 20))
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                Text("Hours")
                    .font(.custom("DOSSaemmul", size: 20))
                Picker("minutePicker", selection: $selectedMinutes) {
                    ForEach(minutes, id: \.self) { minute in
                        Text("\(minute)")
                            .font(.custom("DOSSaemmul", size: 20))
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                Text("Mins")
                    .font(.custom("DOSSaemmul", size: 20))
            }
            
            .frame(width: 318, height: 254, alignment: .center)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 1)
            }
            .padding(.vertical, 20)
            Button {
                let goalTime = hours[hours.firstIndex(of: selectedHours) ?? 0]*60 + minutes[minutes.firstIndex(of: selectedMinutes) ?? 0]
                let DateFormatter = DateFormatter()
                DateFormatter.dateFormat = "yyyy.MM.dd"
                let settedDay = DateFormatter.string(from: Date())
                UserDefaults.shared.set(goalTime, forKey: settedDay)
                testGoalTime = UserDefaults.shared.integer(forKey: settedDay)
            } label: {
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
            .onAppear{
                for (key, value) in UserDefaults.shared.dictionaryRepresentation() {
                   print("\(key), \(value)")
                 }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let today = dateFormatter.string(from: Date())
                if UserDefaults.shared.object(forKey: today) == nil {
                    // 기존 설정된 목표시간이 없다면 4시간 0분이 기본값
                    selectedHours = 4
                    selectedMinutes = 0
                } else {
                    // 기존 설정된 목표시간이 있다면 피커가 그 시간에 맞게 세팅이 되어 나옴
                    testGoalTime = UserDefaults.shared.integer(forKey: today)
                    selectedHours = hours.firstIndex(of: testGoalTime / 60) ?? 4
                    selectedMinutes = minutes.firstIndex(of: testGoalTime % 60) ?? 0
                }
            }
//            Text("현재목표시간 : \(testGoalTime)")
        }
    }
}
