//
//  DailyFeedBack.swift
//  PeepPeep
//
//  Created by MAX on 2023/07/12.
//

import SwiftUI
import DeviceActivity

extension DeviceActivityReport.Context{
    static let diaryActivity = Self("Diary Activity")
}

struct DailyFeedBackView: View {
    @State var isClick: Bool
    @State var month: Date
    @State var nowDay: Date
    @State var stressLevel: Int
    @State var offset: CGSize = CGSize()
    @State var cellColor: Color = .yellow
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                headerView
                calendarGridView
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
                    }
                    else if gesture.translation.width > 10 {
                        changeMonth(by: -1)
                    }
                    self.offset = CGSize()
                }
        )
    }

    private var headerView: some View {
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

    private var calendarGridView: some View {
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
                .foregroundColor(stressLevelColor(stressLevel: stressLevel % 6))
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
    @State private var context: DeviceActivityReport.Context = .diaryActivity
    @State private var filter: DeviceActivityFilter
    init(nowDay: Binding<Date>, stressLevel: Binding<Int>) {
        _nowDay = nowDay
        _stressLevel = stressLevel
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: -1, to: nowDay.wrappedValue + 1) ?? now
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? now
        let dateInterval = DateInterval(start: startOfDay, end: endOfDay)

        _filter = State(initialValue: DeviceActivityFilter(
            segment: .daily(during: dateInterval),
            users: .all,
            devices: .init([.iPhone, .iPad])
        ))
    }

    var body: some View {
        ZStack {
            Image("Paper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .offset(x: -10, y: 10)

            VStack {
                Text("\(nowDay, formatter: Self.dateFormatter)")
                    .font(.custom("DOSSaemmul", size: 13))
                    .padding(.top)
                DeviceActivityReport(context, filter: filter)
                    .frame(width: 150, height: 180)
            }
            Image("Chick")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .offset(x: -120, y: 75)
                .scaleEffect(x: -1, y: 1, anchor: .center)
        }
        .onAppear {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let clickedDate = dateFormatter.string(from: nowDay)
            UserDefaults.shared.set(clickedDate, forKey: "clickedDate")
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
        case 0:
            return Color(hex: "FFE500").opacity(0.1)
        case 1:
            return Color(hex: "FFE500").opacity(0.25)
        case 2:
            return Color(hex: "FFE500").opacity(0.45)
        case 3:
            return Color(hex: "FFE500").opacity(0.65)
        case 4:
            return Color(hex: "FFE500").opacity(1.0)
        case 5:
            return Color(hex: "EF692F").opacity(0.5)
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

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let red = Double((rgb >> 16) & 0xFF) / 255.0
    let green = Double((rgb >>  8) & 0xFF) / 255.0
    let blue = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: red, green: green, blue: blue)
  }
}
