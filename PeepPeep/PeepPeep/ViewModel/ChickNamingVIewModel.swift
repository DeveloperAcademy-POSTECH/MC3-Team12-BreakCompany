//
//  ChickNamingViewModel.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/24.
//

import Foundation

class ChickNamingViewModel: ObservableObject {
    @Published var chick: Chick?

    func updateChickName(name: String) {
        chick = Chick(name: name)
        // 유저디폴트 Key "chickName" 에 병아리 이름을 저장
        UserDefaults.shared.set(name, forKey: "chickName")
    }
}
