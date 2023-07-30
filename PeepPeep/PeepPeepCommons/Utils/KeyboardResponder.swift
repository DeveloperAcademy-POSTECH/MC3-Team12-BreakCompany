//
//  KeyboardResponder.swift
//  PeepPeepCommons
//
//  Created by Ha Jong Myeong on 2023/07/30.
//

import Combine
import SwiftUI

/// 키보드가 보일때, 해당 오브젝트의 위치를 조정합니다.
public class KeyboardResponder: ObservableObject {
    @Published public var isKeyboardVisible = false
    let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        .map { _ in true }
    let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in false }

    private var cancellable: AnyCancellable?

    public init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.isKeyboardVisible, on: self)
    }
}
