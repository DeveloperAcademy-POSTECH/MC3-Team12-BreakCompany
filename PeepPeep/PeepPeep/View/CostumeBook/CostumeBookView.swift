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
                        .padding(.top, 10)
                }
            }
        }
    }
}

//struct CostumeBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        CostumeBookView()
//    }
//}
