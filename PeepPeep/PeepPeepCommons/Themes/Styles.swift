//
//  Styles.swift
//  PeepPeepCommons
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import SwiftUI

/// Underline 형식의 텍스트 필드 스타일을 정의합니다.
public struct UnderlinedTextFieldStyle: TextFieldStyle {
    public init() {}

    // swiftlint:disable:next identifier_name
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 70)
            .padding(.vertical, 10)
            .overlay(
                Divider()
                    .frame(height: 2)
                    .background(Color.black)
                    .padding(.horizontal, 70),
                alignment: .bottom
            )
    }
}

/// 공통으로 쓰이는 버튼 스타일을 정의합니다, paddingSize를 통해 너비의 여백을 조정할 수 있습니다.
public struct CommonButtonStyle: ButtonStyle {
    var paddingSize: CGFloat

    public init(paddingSize: CGFloat = 30) {
        self.paddingSize = paddingSize
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.dosSsaemmul(size: 20))
            .padding(.horizontal, paddingSize)
            .padding(.vertical, 11)
            .foregroundColor(configuration.isPressed ? Color.gray.opacity(0.5) : Color.black)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(configuration.isPressed ?  Color.gray.opacity(0.5) : Color.black, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
