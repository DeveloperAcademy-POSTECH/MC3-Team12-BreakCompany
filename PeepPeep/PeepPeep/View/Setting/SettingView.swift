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
    @State var name: String = ""
    @State var showModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("설정")
                .font(.custom("DOSSaemmul", size: 15))
                .font(.system(size: 20))
                .padding(.bottom, 23)
            
            HStack{
                Text("이름")
                    .frame(width: 70)
                    .font(.custom("DOSSaemmul", size: 15))
                    .foregroundColor(grayColor)
                
                TextField("병아리", text: $name)
                    .font(.custom("DOSSaemmul", size: 15))
                    
            }
            .frame(width: 320, height: 60)
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
            .frame(width: 320, height: 60)
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
        
    }
        
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
