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
    @State var shouldDisplay = false
    @State var isPresented = false
    let center = AuthorizationCenter.shared
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("hahahah")
                .background(.red)
            
        }
        .fullScreenCover(isPresented: $isPresented) {
            MainView()
        }
        
        
        VStack {
            shouldDisplay ? AnyView(ActivitySummaryView()) : AnyView(STProgressView())
        }.onAppear {
            Task {
                do {
                    try await center.requestAuthorization(for: .individual)
                    shouldDisplay = true
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
