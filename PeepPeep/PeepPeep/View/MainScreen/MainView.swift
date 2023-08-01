//
//  MainView.swift
//  PeepPeep
//
//  Created by 이승용 on 2023/07/12.
//
import SwiftUI
import DeviceActivity

extension DeviceActivityReport.Context{
    static let mainActivity = Self("Main Activity")
}

struct MainView: View {
    @State private var context: DeviceActivityReport.Context = .mainActivity
    @State private var showModal = false
    @State private var showModal2 = false
    @State var showTotalActivity = false
    @State var showHelperView = false
    @State private var showLevelModal = false
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
    
    var currentUsageTime: CGFloat = 217  // minutes, 사용시간
    var targetUsageTime: CGFloat = 240   // minutes, 목표시간
    
    let lightGray: Color = Color("LightGray")
    
    var body: some View {
        // swiftlint:disable closure_body_length
        NavigationStack{
            VStack{
                Spacer()
                
                ZStack {
                    // ProgressBarView()
                    DeviceActivityReport(context, filter: filter)
                        .frame(width: UIScreen.main.bounds.width, height: 500, alignment: .center)
                    // 터치하면 모달 올라오기
                    VStack{
                        // 현재 사용 시간 터치
                        Button {
                            showTotalActivity.toggle()
                        } label: {
                            Rectangle()
                                .foregroundColor(.white.opacity(0.1))
                                .frame(width: 99, height: 40)
                            
                        }
                        .sheet(isPresented: $showTotalActivity) {
                            ActivityModalView(model: ScreenTimeAppSelection(), viewModel: ScreenTimeAppSelectionViewModel(), showTotalActivity: $showTotalActivity)
                                .presentationDetents([.height(686)])
                                .presentationDragIndicator(.visible)
                        }
                        
                        Spacer()
                            .frame(height: 93)
                        
                        // 스트레스 지수 게이지바 터치
                        Button {
                            showHelperView.toggle()
                        } label: {
                            Rectangle()
                                .foregroundColor(.white.opacity(0.1))
                                .frame(width: 110, height: 30)
                        }
                        .sheet(isPresented: $showHelperView) {
                            HelperView(showHelperView: $showHelperView)
                                .presentationDetents([.height(686)])
                                .presentationDragIndicator(.visible)
                        }
                        
                        Spacer()
                            .frame(height: 255)
                    }// 터치하면 모달 올라오기
                    
                    
                }
                
                Spacer()
                
                // 하단 메뉴
                HStack(alignment: .center){
                    Spacer()
                    // 옷장 버튼
                    NavigationLink {
                        CostumeBookView()
                    } label: {
                        VStack{
                            Image("Closet")
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .center)
                            Text("옷장")
                                .foregroundColor(.black)
                                .font(.custom("DOSSaemmul", size: 16))
                        }
                    }
                    
                    Spacer()
                    
                    // 성장일지 버튼
                    NavigationLink {
                        DailyFeedBackView(month: Date(), nowDay: Date())
                    } label: {
                        VStack{
                            Image("Diary")
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .center)
                            Text("성장일지")
                                .foregroundColor(.black)
                                .font(.custom("DOSSaemmul", size: 16))
                        }
                    }
                    Spacer()
                    
                    // 시간설정 버튼
                    NavigationLink {
                        SettingView()
                    } label: {
                        VStack{
                            Image("Setting")
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .center)
                            Text("시간설정")
                                .foregroundColor(.black)
                                .font(.custom("DOSSaemmul", size: 16))
                        }
                    }
                    
                    Spacer()
                } // 하단 메뉴 HStack
                Spacer()
            }   // VStack
            .navigationBarBackButtonHidden(true)
        }   // NavigationStack
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
