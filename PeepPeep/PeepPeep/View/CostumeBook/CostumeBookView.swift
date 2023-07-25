//
//  CostumeBookView.swift
//  PeepPeep
//
//  Created by MAX on 2023/07/26.
//

import SwiftUI

struct CostumesBookView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State var isBottomSheet: Bool = false
    var body: some View {
        VStack {
            CostumeGridView
        }
    }
    
    private var CostumeGridView: some View {

        return VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 40) {
                    ForEach(0 ..< 8, id: \.self) { _ in
                        CostumeCellView()
                            .sheet(isPresented: $isBottomSheet, content: {
                                CostumeSheetView()
                                .presentationDetents([.medium, .large])
                            })
                            .onTapGesture {
                                isBottomSheet = true
                            }
                    }
                }
                .padding(10)
            }
            .offset(y: 90)
        }
    }
}

struct CostumeCellView: View {

    var body: some View {
        VStack{
            Rectangle()
                .frame(width: 150, height: 150)
            Text("커스텀 이름")
            Text("선택")
        }
        }
    }

struct CostumeSheetView: View {

    var body: some View {
        VStack{
            Text("커스텀 이름")
            Rectangle()
                .frame(width: 150, height: 150)
            Text("설명")
            Text("선택")
        }
        }
    }


struct CostumesBookView_Previews: PreviewProvider {
    static var previews: some View {
        CostumesBookView()
    }
}
