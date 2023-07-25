//
//  ScreenTimeRequestView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/24.
//

import DeviceActivity
import FamilyControls
import SwiftUI
import PeepPeepCommons

struct ScreenTimeRequestView: View {
    let center = AuthorizationCenter.shared

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            HourGlassImage()
            RequestText()
            DescriptionText()
            ConfirmationButton()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
        .foregroundColor(Color.black)
        .onAppear {
            Task {
                do {
                    try await center.requestAuthorization(for: .individual)
                }
            }
        }
    }
}

struct HourGlassImage: View {
    var body: some View {
        Image("hourglass")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
    }
}

struct RequestText: View {
    var body: some View {
        Text("스크린타임을 승인해주세요")
            .font(.dosSsaemmul(size: 17))
    }
}

struct DescriptionText: View {
    var body: some View {
        Text("핸드폰 사용시간은\n스크린 타임 데이터를 기반으로\n측정됩니다")
            .font(.dosSsaemmul(size: 17))
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)
    }
}

struct ConfirmationButton: View {
    var body: some View {
        Button(action: {
            // Add the action for the button here
        }) {
            NavigationLink(destination: ActivitySummaryView()) {
                Text("승인했어요!")
            }
        }
        .buttonStyle(CommonButtonStyle(paddingSize: 94))
    }
}
