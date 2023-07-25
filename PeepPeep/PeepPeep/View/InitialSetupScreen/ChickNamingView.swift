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
        NavigationView {
            VStack {
                TitleText()
                ChickNameTextField(name: $name)
                ChickImageView()
                DecisionButton(viewModel: viewModel, name: name)
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: SkipButton(viewModel: viewModel, name: name))
            .font(.dosSsaemmul(size: 20))
            .foregroundColor(Color.black)
        }
    }
}

struct TitleText: View {
    var body: some View {
        Text("병아리의 이름을 지어주세요")
            .font(.dosSsaemmul(size: 20))
    }
}

struct ChickNameTextField: View {
    @Binding var name: String

    var body: some View {
        TextField("병아리", text: $name)
            .textFieldStyle(UnderlinedTextFieldStyle())
            .multilineTextAlignment(.center)
            .font(.dosSsaemmul(size: 20))
    }
}

struct ChickImageView: View {
    var body: some View {
        Image("chick")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
    }
}

struct DecisionButton: View {
    let viewModel: ChickNamingViewModel
    let name: String

    var body: some View {
        Button(action: {
            viewModel.updateChickName(name: name)
        }) {
            NavigationLink(destination: ScreenTimeRequestView()) {
                Text("결정")
            }
        }
        .buttonStyle(CommonButtonStyle(paddingSize: 30))
    }
}

struct SkipButton: View {
    let viewModel: ChickNamingViewModel
    let name: String

    var body: some View {
        Button(action: {
            viewModel.updateChickName(name: name)
        }) {
            NavigationLink(destination: ScreenTimeRequestView()) {
                Text("Skip")
            }
        }
    }
}
