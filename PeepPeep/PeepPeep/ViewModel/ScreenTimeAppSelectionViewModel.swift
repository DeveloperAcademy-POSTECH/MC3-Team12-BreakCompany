//
//  ScreenTimeAppSelectionViewModel.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/25.
//

import UIKit
import SwiftUI
import Combine
import FamilyControls

// UIViewController를 상속받아 ScreenTimeAppSelectionViewModel 클래스를 생성
class ScreenTimeAppSelectionViewModel: UIViewController, ObservableObject {
    // ScreenTimeAppSelection 인스턴스 생성
    let model = ScreenTimeAppSelection()

    // Combine 프레임워크의 AnyCancellable을 사용하여 비동기 작업을 관리
    private var cancellables = Set<AnyCancellable>()

    // UserDefaults에 Codable 인스턴스를 인코딩
    private let encoder = PropertyListEncoder()

    // UserDefaults에서 Codable 인스턴스를 디코딩
    private let decoder = PropertyListDecoder()

    // UserDefaults에서 사용할 키를 정의
    private let userDefaultsKey = "ScreenTimeSelection"

    // 뷰가 로드될 때 호출되는 메서드
    override func viewDidLoad() {
        super.viewDidLoad()

        // SwiftUI 뷰인 ActivitySummaryView를 생성하고, 모델을 인자로 전달
        let rootView = ActivitySummaryView(model: model, viewModel: ScreenTimeAppSelectionViewModel())

        // SwiftUI 뷰를 호스팅하는 UIHostingController를 생성하고, 루트 뷰로 설정
        let controller = UIHostingController(rootView: rootView)

        // UIViewController에 UIHostingController를 추가하고, 뷰를 부모 뷰에 추가
        addChild(controller)
        view.addSubview(controller.view)

        // 뷰의 크기를 부모 뷰와 동일하게 설정
        controller.view.frame = view.frame

        // UIViewController가 UIHostingController의 부모가 되었음을 알림
        controller.didMove(toParent: self)
    }

    // 선택된 FamilyActivitySelection 인스턴스를 UserDefaults에 저장하는 메서드
    func saveSelection(selection: FamilyActivitySelection) {
        let defaults = UserDefaults.shared

        defaults.set(
            try? encoder.encode(selection),
            forKey: userDefaultsKey
        )
    }

    // UserDefaults에서 FamilyActivitySelection 인스턴스를 로드하는 메서드
    func loadSelection() -> FamilyActivitySelection? {
        let defaults = UserDefaults.shared

        guard let data = defaults.data(forKey: userDefaultsKey) else {
            return nil
        }

        return try? decoder.decode(
            FamilyActivitySelection.self,
            from: data
        )
    }
}
