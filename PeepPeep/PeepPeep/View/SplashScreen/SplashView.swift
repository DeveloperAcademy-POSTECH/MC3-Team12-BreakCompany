//
//  SplashView.swift
//  PeepPeep
//
//  Created by 예슬 on 2023/07/12.
//

import SwiftUI
import PeepPeepCommons

struct SplashView: View {
    @State var goNext: Bool = false

    var body: some View {
        NavigationStack {
            TabView {
                ZStack {
                    Text("이상한 아저씨가 학교 앞에서 무엇인가 팔고 있다")
                        .font(.custom("DOSSaemmul", size: 17))
                        .lineSpacing(19)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .offset(y: -200)

                    Image("BoxOff")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .offset(y: 50)
                }

                ZStack {
                    Text("앗 병아리잖아?\n옛날부터 너무 키워보고 싶었는데...")
                        .font(.custom("DOSSaemmul", size: 17))
                        .lineSpacing(19)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .offset(y: -200)

                    Image("Base1")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .offset(y: 50)
                }

                ZStack {
                    Text("\"병아리는 많이 만지면 아프단다.\"")
                        .font(.custom("DOSSaemmul", size: 17))
                        .lineSpacing(19)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .offset(y: -200)

                    Image("Base1")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .offset(y: 50)
                }

                ZStack {
                    Text("\"핸드폰을 만지는 동안\n병아리가 스트레스를 받으니,\n주의해서 잘 키워주거라!\"")
                        .font(.custom("DOSSaemmul", size: 17))
                        .lineSpacing(19)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .offset(y: -200)

                    Image("Base1")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .offset(y: 50)
                }

                ZStack {
                    Text("우리집으로 가장!")
                        .font(.custom("DOSSaemmul", size: 17))
                        .lineSpacing(19)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .offset(y: -200)
                    Image("BoxOn")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .offset(y: 50)
                    VStack {
                        Rectangle().foregroundColor(.clear)
                        Button(action: {
                        }) {
                            NavigationLink(destination: ScreenTimeRequestView()) {
                                Text("다음")
                            }
                        }
                        .buttonStyle(CommonButtonStyle(paddingSize: 30))
                        Spacer(minLength: 115)
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .onAppear {
                setupAppearance()
            }
            .padding(.bottom, 50)
        }
    }

    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
