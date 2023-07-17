//
//  DailyFeedBack.swift
//  PeepPeep
//
//  Created by MAX on 2023/07/12.
//

import SwiftUI

struct DailyFeedBackView: View {
    @Binding var isClick: Bool
    @State var month: Date
    @State var offset: CGSize = CGSize()
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
                    CellView(day: day, cellColor: .yellow)
                        .padding(.bottom, 5)
                }
            }
        }
    }
}
    

struct CellView: View {
    @State var isClick: Bool = false
    @State var cellColor: Color
    @State var day: Int
    
    init(day: Int, cellColor: Color) {
        self.day = day
        self.cellColor = cellColor
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(cellColor)
                .frame(width: 40, height: 40)
            
            if isClick {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
            }
            
            Text("\(day)")
                .frame(width: 50, height: 50)
                .cornerRadius(3)
        }
        .onTapGesture {
            self.isClick.toggle()
        }
        .sheet(isPresented: $isClick) {
            ResultSheetView(day: $day)
        }
    }
}

struct ResultSheetView: View {
    @Binding var day: Int
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.25)
                .edgesIgnoringSafeArea(.all)
            Image("Paper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .offset(x: -10)
            
            VStack {
                Text("\(day)일")
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
                Text("90%")
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

struct DailyFeedBackView_Previews: PreviewProvider {
    static var previews: some View {
        DailyFeedBackView(isClick: .constant(false), month: Date())
    }
}
