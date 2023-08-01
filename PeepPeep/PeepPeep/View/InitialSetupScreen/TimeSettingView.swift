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
    @State var buttonDisabledCheck = false
    @State var selectedHours = 4
    @State var selectedMinutes = 0
    @State var goalTime: Int = 240
    @State var testGoalTime = 0
    
    var body: some View {
        VStack {
            Text("핸드폰 목표 사용 시간 설정")
                .font(.custom("DOSSaemmul", size: 17))
                .padding(.vertical, 20)
            Text("하루에 한번만 설정을 바꿀 수 있습니다")
                .font(.custom("DOSSaemmul", size: 13))
                .padding(.vertical, 20)
                .foregroundColor(buttonDisabledCheck ? .red : .black)
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
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let settedDay = dateFormatter.string(from: Date())
                UserDefaults.shared.set(goalTime, forKey: settedDay)
                testGoalTime = UserDefaults.shared.integer(forKey: settedDay)
                //버튼이 터치되면서 버튼색,글씨색이 바뀜
                buttonDisabledCheck = true
            } label: {
                Text("결정")
                    .frame(width: 106, height: 44)
                    .font(.custom("DOSSaemmul", size: 20))
                    //오늘 설정을 한번 설정을 한 상태라면 버튼 색이 라이트그레이로 바뀜
                    .foregroundColor(buttonDisabledCheck ? Color("LightGray") : .black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(buttonDisabledCheck ? Color("LightGray") : .black, lineWidth: 1)
                    }
            }
            .disabled(buttonDisabledCheck)
            .padding(.vertical, 20)
            .onAppear{
                for (key, value) in UserDefaults.shared.dictionaryRepresentation() {
                   print("\(key), \(value)")
                 }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let today = dateFormatter.string(from: Date())
                // 오늘 날짜의 목표시간이 없으면 가장 최근에 설정한 목표시간을 찾아 피커에 띄워준다
                if UserDefaults.shared.object(forKey: today) == nil {
                    var dayCount = 0
                    while (UserDefaults.shared.object(forKey: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: dayCount, to: Date())!)) == nil){
                        dayCount -= 1
                    }
                    goalTime = UserDefaults.shared.integer(forKey: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: dayCount, to: Date())!))
                    selectedHours = hours.firstIndex(of: goalTime / 60) ?? 4
                    selectedMinutes = minutes.firstIndex(of: goalTime % 60) ?? 0

                } else {
                    // 오늘 설정된 목표시간이 있으면 buttonDisabledCheck 를 true 로 바꾸어 클릭이 안되게 한다, 피커도 오늘 날짜 기준으로 설정
                    goalTime = UserDefaults.shared.integer(forKey: today)
                    selectedHours = hours.firstIndex(of: goalTime / 60) ?? 4
                    selectedMinutes = minutes.firstIndex(of: goalTime % 60) ?? 0
                    buttonDisabledCheck = true
                }
            }
//            Text("현재목표시간 : \(testGoalTime)")
        }
    }
}
