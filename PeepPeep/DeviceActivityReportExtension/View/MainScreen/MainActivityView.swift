//
//  MainActivityView.swift
//  DeviceActivityReportExtension
//
//  Created by 이승용 on 2023/07/25.
//

import SwiftUI

struct MainActivityView: View {
    let mainActivity : String
    let lightGreen: Color = Color("LightGreen")
    
    var body: some View {
        Text(mainActivity)
        ChickStatusView()
    }
}
