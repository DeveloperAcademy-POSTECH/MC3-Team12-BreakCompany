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
            ProgressBar(currentStep: 2)
            Spacer()
            HourGlassImage()
            RequestText()
            CustomSpacer(height: 50)
            DescriptionText()
            CustomSpacer(height: 80)
            ConfirmationButton()
            CustomSpacer(height: 30)
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

// 모래시계 이미지 뷰
struct HourGlassImage: View {
    var body: some View {
        Image("hourglass")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 288, height: 288)
    }
}

// 스크린타임 요청 텍스트
struct RequestText: View {
    var body: some View {
        Text("스크린타임을 승인해주세요")
            .font(.dosSsaemmul(size: 17))
    }
}

// 스크린타임 설명 텍스트
struct DescriptionText: View {
    var body: some View {
        Text("핸드폰 사용시간은\n스크린 타임 데이터를 기반으로\n측정됩니다")
            .font(.dosSsaemmul(size: 17))
            .lineSpacing(3)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)
    }
}

// 확인 버튼
struct ConfirmationButton: View {
    var body: some View {
        Button(action: {
        }) {
            NavigationLink(destination: ActivitySummaryView()
                .environmentObject(ScreenTimeAppSelection.shared)) {
                Text("확인")
            }
        }
        .buttonStyle(CommonButtonStyle(paddingSize: 30))
    }
}
