//
//  EmptyActivity.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/30.
//

import SwiftUI
import PeepPeepCommons

struct EmptyActivityView: View {
    var body: some View {
        VStack {
            NoDataCircle()
            CustomSpacer(height: 70)
            NoDataMessage()
            CustomSpacer(height: 30)
            ChooseAppMessage()
        }
    }
}

struct NoDataCircle: View {
    var body: some View {
        Circle()
            .stroke(Color.gray.opacity(0.4), lineWidth: 14)
            .frame(width: 180, height: 180)
            .overlay(
                NoDataText()
            )
    }
}

struct NoDataText: View {
    var body: some View {
        Text("이전 내역이 없습니다.")
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .font(.dosSsaemmul(size: 15))
    }
}

struct NoDataMessage: View {
    var body: some View {
        Text("스크린 타임에 이전 내역이 없어\n어제 휴대폰을 사용한 시간을\n불러올 수 없습니다.")
            .multilineTextAlignment(.center)
            .lineSpacing(10)
            .font(.dosSsaemmul(size: 17))
    }
}

struct ChooseAppMessage: View {
    var body: some View {
        Text("사용시간을 줄이고 싶은 앱을\n선택해주세요.")
            .multilineTextAlignment(.center)
            .lineSpacing(10)
            .font(.dosSsaemmul(size: 17))
    }
}
