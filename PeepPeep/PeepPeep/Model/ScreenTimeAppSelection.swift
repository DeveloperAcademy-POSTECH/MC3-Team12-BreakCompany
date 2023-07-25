//
//  ScreenTimeAppSelection.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/25.
//

import FamilyControls
import Foundation

class ScreenTimeAppSelection: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()

    init() { }
}
