//
//  CostumeBookView.swift
//  PeepPeep
//
//  Created by MAX on 2023/07/26.
//

import SwiftUI

struct CostumesBookView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let costumeNames: Array = ["Normal", "Cake", "Moon", "Music", "Newbie", "Clover", "Apple", "Bag1"]
    
    @State var isBottomSheet: Bool = false
    @State var costumeName: String = ""
    @State var isSelect: Bool = false
    
    var body: some View {
        VStack {
            CostumeGridView
        }
    }
    
    private var CostumeGridView: some View {

        return VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 40) {
                    ForEach(0 ..< 8, id: \.self) { i in
                        CostumeCellView(costumeName: costumeNames[i], isSelect: $isSelect)
                            .sheet(isPresented: $isBottomSheet, content: {
                                CostumeSheetView(costumeName: $costumeName, isSelect: $isSelect)
                                .presentationDetents([.medium])
                                .presentationDragIndicator(.visible)
                            })
                            .onTapGesture {
                                costumeName = costumeNames[i]
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
    @State var costumeName: String
    @Binding var isSelect: Bool
    
    var body: some View {
        VStack{
            Image("\(costumeName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Text("\(costumeName)")
            if isSelect {
                Text("선택")
            }
        }
        }
    }

struct CostumeSheetView: View {
    @Binding var costumeName: String
    @Binding var isSelect: Bool
    let costumeTitleDict: [String: String] = [
        "Normal": "클래식",
        "Cake": "우리 백 일이에요",
        "Moon": "한 달 살기",
        "Music": "무병 장수",
        "Newbie": "시작이 반이다",
        "Clover": "슬롯 머신",
        "Apple": "얼리어답터",
        "Bag1": "돌아온 탕아"
    ]
    
    let costumeExplainDict: [String: String] = [
        "Normal": "기본으로 제공되는 병아리입니다.",
        "Cake": "설정한 핸드폰 사용시간을 잘 지킨날이 100일이 되면 지급됩니다.",
        "Moon": "한 달 연속으로 핸드폰 목표 사용 시간을 잘 지켰을 때 지급됩니다.",
        "Music": "설정한 핸드폰 사용시간을 일주일 연속으로 잘 지켰을 때 지급됩니다.",
        "Newbie": "설정한 핸드폰 사용시간을 1일 잘 지키면 지급됩니다.",
        "Clover": "3일 연속으로 병아리의 스트레스 지수를 33.3%로 유지했을 때 지급됩니다.",
        "Apple": "발표날 앱을 설치하시면 지급됩니다.",
        "Bag1": "설정한 핸드폰 사용시간을 지키지 못해 병아리가 처음 가출했을 때 지급됩니다."
    ]
    
    var body: some View {
        VStack {
            ZStack{
                HStack {
                    Spacer()
                    Text("\(costumeTitleDict[costumeName]!)")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Spacer()
                    Image(systemName: "x.circle.fill")
                        .padding()
                }
            }
            VStack {
                ZStack {
                    Image("\(costumeName)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                    Text("\(costumeExplainDict[costumeName]!)")
                        .frame(width: 300, height: 300)
                        .lineLimit(2)
                        .offset(y: 120)
                }
                Button(
                    action: {
                        isSelect.toggle()
                    },
                    label: {
                        Text("선택")
                            .font(.title)
                    }
                )
            }
        }
    }
}


struct CostumesBookView_Previews: PreviewProvider {
    static var previews: some View {
        CostumesBookView()
    }
}
