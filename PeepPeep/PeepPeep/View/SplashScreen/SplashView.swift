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
    @State var loadingViewOpacity: CGFloat = 1.0

    var body: some View {
        NavigationStack {
            TabView {
                ZStack {
                    VStack{
                        Text("이상한 아저씨가 학교 앞에서\n무엇인가 팔고 있다")
                            .font(.custom("DOSSaemmul", size: 17))
                            .lineSpacing(19)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        
                        Spacer()
                            .frame(height: 471)
                    }

                    Image("ChickSeller2")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .offset(y: 60)
                }

                ZStack {
                    VStack {
                        Text("앗 병아리잖아?\n옛날부터 너무 키워보고 싶었는데...")
                            .font(.custom("DOSSaemmul", size: 17))
                            .lineSpacing(19)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            
                        Spacer()
                            .frame(height: 471)
                    }

                    Image("Chick")
                        .resizable()
                        .frame(width: 302, height: 302)
                        .offset(y: 60)
                }

                ZStack {
                    VStack {
                        Text("\"병아리는 많이 만지면 아프단다.\"")
                            .font(.custom("DOSSaemmul", size: 17))
                            .lineSpacing(19)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        
                        Spacer()
                            .frame(height: 486)
                    }

                    Image("ChickSeller3")
                        .resizable()
                        .frame(width: 397, height: 397)
                        .offset(y: 50)
                }

                ZStack {
                    VStack {
                        Text("\"핸드폰을 만지는 동안\n병아리가 스트레스를 받으니,\n주의해서 잘 키워주거라!\"")
                            .font(.custom("DOSSaemmul", size: 17))
                            .lineSpacing(19)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        
                        Spacer()
                            .frame(height: 456)
                    }

                    Image("ChickSeller3")
                        .resizable()
                        .frame(width: 499, height: 499)
                        .offset(y: 50)
                }

                ZStack {
                    VStack {
                        Text("우리집으로 가장!")
                            .font(.custom("DOSSaemmul", size: 17))
                            .lineSpacing(19)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        
                        Spacer()
                            .frame(height: 471)
                    }

                    Image("ChickInBox")
                        .resizable()
                        .frame(width: 280, height: 280)
                        .offset(y: 60)
                    VStack {
                        Rectangle().foregroundColor(.clear)
                        Button(action: {
                        }) {
                            NavigationLink(destination: ChickNamingView()) {
                                Text("다음")
                            }
                        }
                        .buttonStyle(CommonButtonStyle(paddingSize: 30))
                        
                        Spacer(minLength: 105)
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .onAppear {
                setupAppearance()
            }
            .padding(.bottom, 31)
        }
    }

    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3)
    }

    struct SplashView_Previews: PreviewProvider {
        static var previews: some View {
            SplashView()
        }
    }
}
