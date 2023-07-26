//
//  TimeSettingView.swift
//  PeepPeep
//
//  Created by 이승용 on 2023/07/26.
//

import SwiftUI
import DeviceActivity

struct TimeSettingView: View {
    let hours = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    let minutes = [0, 10, 20, 30, 40, 50]
    @State var selectedHours = 4
    @State var selectedMinutes = 0
    
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
                print("결정")
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
        }
    }
}
