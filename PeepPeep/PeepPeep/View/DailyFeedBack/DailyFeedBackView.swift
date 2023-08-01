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

struct CellBox: Identifiable {
    let id = UUID()
    let num: Int
    let nowDay: Date
    let color: Color
    let level: Int
}

struct DailyFeedBackView: View {
    
    // 각 날짜 별 스트레스 레벨 값. 아직 존재하지 않는 값의 경우 0으로 처리.
    let levels = [
        10, 29, 32, 43,
        65, 84, 24, 12,
        35, 46, 84, 43,
        33, 77, 45, 78,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0
    ]
    
    var boxes: [CellBox] {
        
        var result: [CellBox] = []
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month)
        let totalDay: Int = firstWeekday + daysInMonth
        
        // 숫자와 색상을 반복문으로 생성하여 배열로 반환
        for index in 1..<totalDay {
            let num: Int = (index < firstWeekday) ? 0 : index - firstWeekday + 1
            // num으로 받아온 값을 getDate로 날짜로 저장
            let nowDay = getDate(for: num - 1)
            let level = Int.random(in: 1...120)
            let color = stressLevelColor(stressLevel: level)

            
            result.append(CellBox(num: num, nowDay: nowDay, color: color, level: level))
        }
        return result
    }
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    
    @State var clickNum: Int = 0
    @State var level: Int = 0
    @State var month: Date
    // CellBoxView의 날짜를 DiaryView에 연결하기 위해 만들어진 변수
    @State var nowDay: Date
    @State var offset: CGSize = CGSize()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            VStack {
                
                headerView
                
                // 그리드로 박스 생성
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(boxes) { box in
                        CellBoxView(box: box, clickNum: $clickNum, level: $level, nowDay: $nowDay)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            
            // 날짜 누르면 결과 페이지 나오는 부분
            if clickNum > 0 {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        clickNum = 0
                    }
                DiaryView(nowDay: $nowDay)
            }
        }
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
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
    private var backButton: some View{
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 17))
                .padding(.leading, 10)
                .padding(.top, 10)
        }
    }
    
    private var headerView: some View {
        return VStack {
            Text(month, formatter: Self.dateFormatter)
                .font(.custom("DOSSaemmul", size: 16))
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(Self.weekdaySymbols.indices, id: \.self) { week in
                    Text("\(Self.weekdaySymbols[week])")
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(.systemGray))
                        .font(.custom("DOSSaemmul", size: 16))
                }
            }
        }
    }
}

struct CellBoxView: View {
    let box: CellBox
    @State var downloadedDate = ""
    @Binding var clickNum: Int
    @Binding var level: Int
    @Binding var nowDay: Date
    let dateFormatter = DateFormatter()
    
    
    var body: some View {
        ZStack{
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundColor((box.num != 0) ? box.color : .white)
//                .frame(width: 40, height: 40)
            if box.nowDay.compare((dateFormatter.date(from: downloadedDate)!)) == .orderedAscending || box.nowDay.compare(Date()) == .orderedDescending || box.num == 0 {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(box.color)
                    .frame(width: 40, height: 40)
            }
            if box.num > 0 {
                Text("\(box.nowDay, formatter: Self.dateFormatter)")
                    .font(.custom("DOSSaemmul", size: 15))
                    .foregroundColor(.black)
                    .frame(width: 50, height: 50)
                    
            }else{
                Text("")
                .frame(width: 50, height: 50)
            }
        }
        .onTapGesture {
            clickNum = box.num
//            Level = box.Level
            // box의 nowDay를 DiaryView에 전달(바인딩으로 묶어서)
            nowDay = box.nowDay
        }
        .onAppear{
            dateFormatter.dateFormat = "yyyy.MM.dd"
            downloadedDate = UserDefaults.shared.string(forKey: "downloadedDate") ?? "2023.07.17"
        }
    }
}

struct DiaryView: View {
//    @Binding var month: Date
//    @Binding var clickNum: Int
//    @Binding var Level: Int
    @Binding var nowDay: Date
    @State private var context: DeviceActivityReport.Context = .diaryActivity
    @State private var filter: DeviceActivityFilter
    init(nowDay: Binding<Date>) {
        _nowDay = nowDay
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: nowDay.wrappedValue) ?? now
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
            Image("Note")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .offset(x: -10, y: 10)

            VStack {
                Text("\(nowDay, formatter: Self.dateFormatter)")
                    .font(.custom("DOSSaemmul", size: 17))
                    .padding(.vertical, 10)
                    
                DeviceActivityReport(context, filter: filter)
                    .frame(width: 120, height: 144)
                    
            }
            Image("Chick")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 180)
                .offset(x: -104, y: 75)
                .scaleEffect(x: -1, y: 1, anchor: .center)
        }
        .offset(y: -50)
        .onAppear{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let clickedDate = dateFormatter.string(from: nowDay)
            UserDefaults.shared.set(clickedDate, forKey: "clickedDate")
        }
    }
}

private extension DailyFeedBackView {
    func stressLevelColor(stressLevel: Int = 90) -> Color {
        switch stressLevel {
        case 0...20:
            return Color(hex: "FFE500").opacity(0.1)
        case 21...40:
            return Color(hex: "FFE500").opacity(0.25)
        case 41...60:
            return Color(hex: "FFE500").opacity(0.45)
        case 61...80:
            return Color(hex: "FFE500").opacity(0.65)
        case 81...100:
            return Color(hex: "FFE500").opacity(1.0)
        case 100...120:
            return Color(hex: "EF692F").opacity(0.5)
        default:
            return Color.red
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

private extension CellBoxView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "d"
        return formatter
    }()
}

private extension DiaryView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일"
        return formatter
    }()
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
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DailyFeedBackView(month: Date(), nowDay: Date())
    }
}
