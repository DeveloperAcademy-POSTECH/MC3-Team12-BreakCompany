//
//  InitialSetupView.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import DeviceActivity
import FamilyControls
import SwiftUI

struct InitialSetupView: View {
    @State var show = false
    let center = AuthorizationCenter.shared
    
    var body: some View {
        VStack {
            if show {
                ActivitySummaryView()
            }
            else {
                STProgressView()
            }
        }.onAppear {
            Task {
                do {
                    try await center.requestAuthorization(for: .individual)
                    show = true
                }
            }
        }
    }
}

struct STProgressView: View {
    var body: some View {
        ProgressView {
            Text("Loading")
        }
    }
}
