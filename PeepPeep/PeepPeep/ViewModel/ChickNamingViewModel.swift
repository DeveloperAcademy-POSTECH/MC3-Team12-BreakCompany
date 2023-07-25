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
    }
}
