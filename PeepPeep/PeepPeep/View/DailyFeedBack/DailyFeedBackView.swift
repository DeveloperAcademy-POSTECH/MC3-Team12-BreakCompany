//
//  DailyFeedBack.swift
//  PeepPeep
//
//  Created by MAX on 2023/07/12.
//

import SwiftUI

struct DailyFeedBackView: View {
    @State var isClick: Bool
    @State var month: Date
    @State var nowDay: Date
    @State var stressLevel: Int
    @State var offset: CGSize = CGSize()
    @State var cellColor: Color = .yellow
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                HeaderView
                CalendarGridView
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .padding(30)
            
            if isClick {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isClick = false
                    }
                DiaryView(nowDay: $nowDay, stressLevel: $stressLevel)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in self.offset = gesture.translation
                }
                .onEnded { gesture in
                    if gesture.translation.width < 10 {
                        changeMonth(by: 1)
                    } else if gesture.translation.width > 10 {
                        changeMonth(by: -1)
                    }
                    self.offset = CGSize()
                }
        )
    }
    
    
    private var HeaderView: some View {
        return VStack {
            Text(month, formatter: Self.dateFormatter)
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(Self.weekdaySymbols.indices, id: \.self) { week in
                    Text("\(Self.weekdaySymbols[week])")
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(.systemGray))
                }
            }
        }
    }
    
    private var CalendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(0 ..< firstWeekday, id: \.self) { _ in
                    Text("")
                        .frame(width: 50, height: 50)
                }
                
                ForEach(1 ..< daysInMonth + 1, id: \.self) { day in
                    CellView(day: day, stressLevel: day)
                        .padding(.bottom, 20)
                        .onTapGesture {
                            isClick = true
                            nowDay = getDate(for: day) - 1
                            stressLevel = day
                        }
                }
            }
        }
    }
}

struct CellView: View {
    @State var day: Int
    @State var stressLevel: Int
    
    init(day: Int, stressLevel: Int) {
        self.day = day
        self.stressLevel = stressLevel
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(stressLevelColor(stressLevel: stressLevel))
                .frame(width: 40, height: 40)
            
            Text("\(day)")
                .frame(width: 50, height: 50)
                .cornerRadius(3)
            }
        }
    }

struct DiaryView: View {
    @Binding var nowDay: Date
    @Binding var stressLevel: Int
    
    var body: some View {
        ZStack{
            Image("Paper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .offset(x: -10, y: 10)
            
            Image("Chick")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .offset(x: -120, y: 75)
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            VStack {
                Text("\(nowDay, formatter: Self.dateFormatter)")
                    .font(.title2)
                    .padding(.bottom)
                
                VStack {
                    Text("사용시간")
                    Text("00 : 00")
                        .font(.title)
                }
                .padding(.bottom)
                
                Text("스트레스 지수")
                    .padding(.bottom, 3)
                Text("\(stressLevel)%")
                    .font(.title2)
            }
        }
    }
}

private extension DailyFeedBackView {
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}

private extension DailyFeedBackView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }()
    
    static let weekdaySymbols: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.shortWeekdaySymbols
    }()
}

private extension CellView {
    func stressLevelColor(stressLevel: Int = 90) -> Color {
        switch stressLevel {
        case 0...20:
            return Color.blue
        case 21...40 :
            return Color.green
        case 41...60 :
            return Color.yellow
        case 61...80 :
            return Color.orange
        case 81...100 :
            return Color.pink
        default:
            return Color.red
        }
    }
}

private extension DiaryView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일"
        return formatter
    }()
}

struct DailyFeedBackView_Previews: PreviewProvider {
    static var previews: some View {
        DailyFeedBackView(isClick: false, month: Date(), nowDay: Date(), stressLevel: 0)
    }
}
