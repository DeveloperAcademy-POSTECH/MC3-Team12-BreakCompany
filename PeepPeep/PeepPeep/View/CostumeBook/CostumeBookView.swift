//
//  CostumeBookView.swift
//  PeepPeep
//
//  Created by Youngbin Choi on 2023/07/31.
//

import SwiftUI
import DeviceActivity

extension DeviceActivityReport.Context{
    static let costumeActivity = Self("Costume Activity")
}

struct CostumeBookView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var context: DeviceActivityReport.Context = .costumeActivity
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            DeviceActivityReport(context)
        }
        .edgesIgnoringSafeArea(.vertical)
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
        .gesture(
                    DragGesture()
                        .updating($dragOffset, body: { (value, state, _) in
                            state = value.translation.width
                        })
                        .onEnded({ value in
                            if value.translation.width > 100 {
                                presentationMode.wrappedValue.dismiss()
                            }
                        })
                )
    }
    private var backButton: some View{
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 17))
                .padding(.leading, 10)
                .padding(.top, 10)
        }
    }
}
