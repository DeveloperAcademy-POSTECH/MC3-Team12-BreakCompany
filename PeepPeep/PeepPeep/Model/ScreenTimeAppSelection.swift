//
//  ScreenTimeAppSelection.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/25.
//

import FamilyControls
import Foundation
import ManagedSettings
import DeviceActivity

class ScreenTimeAppSelection: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()

    init() { }
}
