//
//  ChickNamingView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/24.
//

import SwiftUI
import PeepPeepCommons

struct ChickNamingView: View {
    @ObservedObject var viewModel = ChickNamingViewModel()

    @State private var name = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("병아리의 이름을 지어주세요")
                    .font(.dosSsaemmul(size: 20))
                TextField("병아리", text: $name)
                    .textFieldStyle(UnderlinedTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .font(.dosSsaemmul(size: 20))
                Image("chick")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Button(action: {
                    viewModel.updateChickName(name: name)
                }) {
                    NavigationLink(destination: ScreenTimeRequestView()) {
                        Text("결정")
                    }
                }
                .buttonStyle(CommonButtonStyle(paddingSize: 30))
            }
            .padding()
        }
    }
}
