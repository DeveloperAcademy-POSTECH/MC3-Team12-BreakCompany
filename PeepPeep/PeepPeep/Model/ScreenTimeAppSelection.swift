//
//  ScreenTimeAppSelection.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/25.
//
import FamilyControls
import Foundation
import ManagedSettings

class ScreenTimeAppSelection: ObservableObject {
    static let shared = ScreenTimeAppSelection()

    @Published var newSelection: FamilyActivitySelection = .init()

    var selectedAppTokens: Set<ApplicationToken> {
        newSelection.applicationTokens
    }
}
