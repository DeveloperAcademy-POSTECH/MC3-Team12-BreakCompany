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
    @State private var showTotalActivity = false
    @State private var showHelperView = false
    @State private var showLevelModal = false
    @State private var filter: DeviceActivityFilter = {
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
        NavigationStack{
            VStack{
                Spacer()
                    .frame(height: 77)
                
                ZStack {
                    // ProgressBarView()
                    DeviceActivityReport(context, filter: filter)
                        .frame(width: 300, height: 500, alignment: .center)
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
                            Text("앱 사용 통계")
                                .presentationDetents([.height(684)])
                                .presentationDragIndicator(.visible)
                        }
                        
                        Spacer()
                            .frame(height: 81)
                        
                        // 스트레스 지수 게이지바 터치
                        Button {
                            showHelperView.toggle()
                        } label: {
                            Rectangle()
                                .foregroundColor(.white.opacity(0.1))
                                .frame(width: 110, height: 30)
                        }
                        .sheet(isPresented: $showHelperView) {
                            HelperView()
                                .presentationDetents([.height(684)])
                                .presentationDragIndicator(.visible)
                        }
                        
                        Spacer()
                            .frame(height: 234)
                        
                        // 레벨 터치
                        Button {
                            showLevelModal.toggle()
                        } label: {
                            Rectangle()
                                .foregroundColor(.white.opacity(0.1))
                                .frame(width: 49, height: 18)
                        }
                        .sheet(isPresented: $showLevelModal) {
                            // 레벨 설명
                            VStack{
                                Text("병아리의 레벨")
                                    .font(.custom("DOSSaemmul", size: 20))
                                    .padding(.bottom, 18)
                                
                                Image("chick")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .padding(.bottom, 26)
                                
                                Text("레벨은 목표 사용 시간을 잘 지킨 날짜예요.")
                                    .font(.custom("DOSSaemmul", size: 17))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 25)
                                
                                Text("하루 목표 사용 시간을 잘 지키면\n레벨이 1 증가해요.")
                                    .font(.custom("DOSSaemmul", size: 17))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 25)
                                    .lineSpacing(10)
                                
                                Text("하루 목표 사용 시간을 잘 지키지 못하면\n레벨이 오르지 않아요.")
                                    .font(.custom("DOSSaemmul", size: 17))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(10)
                                
                            }
                            .presentationDetents([.height(419)])
                            .presentationDragIndicator(.visible)
                        }
                        
                        
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
                        DailyFeedBackView(isClick: false, month: Date(), nowDay: Date(), stressLevel: 0)
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
            .onAppear{
                //앱이 처음 다운로드 된 날, 그 날의 목표시간을 유저디폴트에 저장합니다(향후 온보딩 및 초기 설정 페이지로 옮겨야 합니다)
                UserDefaults.shared.set("2023.07.17", forKey: "downloadedDate")
                UserDefaults.shared.set(600, forKey: "2023.07.17")
            }
        }   // NavigationStack
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

