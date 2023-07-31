//
//  CostumeBookView.swift
//  PeepPeep
//
//  Created by MAX on 2023/07/26.
//

import SwiftUI
import DeviceActivity

extension DeviceActivityReport.Context{
    static let costumeActivity = Self("Costume Activity")
}

struct CostumeBookView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var context: DeviceActivityReport.Context = .costumeActivity
    var body: some View {
        VStack {
            DeviceActivityReport(context)
        }
        .edgesIgnoringSafeArea(.vertical)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17))
                        .padding(.leading, 10)

                }

            }
        }
    }
}
