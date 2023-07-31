//
//  SettingView.swift
//  PeepPeep
//
//  Created by 예슬 on 2023/07/26.
//

import SwiftUI
import Foundation

struct SettingView: View {
    
    let grayColor: Color = Color("GrayColor")
    @State var chickName: String = ""
    @FocusState private var focusedField: Field?
    @State var showModal = false
    
    enum Field: Hashable {
            case chickName
        }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("설정")
                    .font(.custom("DOSSaemmul", size: 20))
                    .padding(.bottom, 21)
                
                HStack{
                    Text("이름")
                        .frame(width: 30)
                        .font(.custom("DOSSaemmul", size: 15))
                        .foregroundColor(grayColor)
                        .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 50))
                    
                    TextField(chickName, text: $chickName)
                        .font(.custom("DOSSaemmul", size: 15))
                        .onSubmit {
                            UserDefaults.shared.set(chickName, forKey: "chickName")
                        }
                        .focused($focusedField, equals: .chickName)
                        .textContentType(.name) // 한국어 키보드 먼저 띄우기
                    
                }
                .frame(width: 320, height: 61)
                .overlay(){
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black)
                }
                .padding(.bottom, 35)
                
                Button {
                    self.showModal.toggle()
                } label: {
                    Text("핸드폰 사용 시간 설정")
                        .font(.custom("DOSSaemmul", size: 15))
                        .foregroundColor(.black)
                }
                .frame(width: 320, height: 61)
                .overlay(){
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black)
                }
                .sheet(isPresented: $showModal) {
                    TimeSettingView()
                        .presentationDetents([.height(724)])
                        .presentationDragIndicator(.visible)
                }
                
                Spacer()
                
            } // VStack
        } // ScrollView
        .onAppear{
            chickName = UserDefaults.shared.string(forKey: "chickName") ?? "병아리"
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
