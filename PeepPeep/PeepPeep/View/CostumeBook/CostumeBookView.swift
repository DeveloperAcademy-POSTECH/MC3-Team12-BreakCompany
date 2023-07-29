//
//  CostumeBookView.swift
//  PeepPeep
//
//  Created by MAX on 2023/07/26.
//

import SwiftUI

struct CostumeCell: Identifiable {
    let id = UUID()
    let cellNum: Int
    let imageName: String
    let imageTitle: String
    let imageExplain: String
    var isUnlocked: Bool
    
    init(cellNum: Int, imageName: String, imageTitle: String, imageExplain: String, isUnlocked: Bool) {
        self.cellNum = cellNum
        self.imageName = imageName
        self.imageTitle = imageTitle
        self.imageExplain = imageExplain
        self.isUnlocked = isUnlocked
    }
}

struct CostumesBookView: View {
    
    // 이미지 해금 여부 리스트
    let isUnlockedImages = [
        false, true, false, true,
        true, false, false, true,
        true, true
    ]
    
    let costumeNames: Array = ["Normal", "Cake", "Moon", "Music", "Newbie", "Clover", "Apple", "Bag1"]
    
    let costumeShadowNames: Array = ["NormalShadow", "CakeShadow", "MoonShadow", "MusicShadow", "NewbieShadow", "CloverShadow", "AppleShadow", "Bag1Shadow"]
    
    let costumeTitles: [String] = [
        "클래식",
        "우리 백 일이에요",
        "한 달 살기",
        "무병 장수",
        "시작이 반이다",
        "슬롯 머신",
        "얼리어답터",
        "돌아온 탕아"
    ]
    
    let costumeExplains: [String] = [
        "기본으로 제공되는 병아리입니다.",
        "설정한 핸드폰 사용시간을 잘 지킨날이 100일이 되면 지급됩니다.",
        "한 달 연속으로 핸드폰 목표 사용 시간을 잘 지켰을 때 지급됩니다.",
        "설정한 핸드폰 사용시간을 일주일 연속으로 잘 지켰을 때 지급됩니다.",
        "설정한 핸드폰 사용시간을 1일 잘 지키면 지급됩니다.",
        "3일 연속으로 병아리의 스트레스 지수를 33.3%로 유지했을 때 지급됩니다.",
        "발표날 앱을 설치하시면 지급됩니다.",
        "설정한 핸드폰 사용시간을 지키지 못해 병아리가 처음 가출했을 때 지급됩니다."
    ]
    
    var cells: [CostumeCell] {
        var result: [CostumeCell] = []
        for i in 0...7 {
            let isUnlockedImage = isUnlockedImages[i]
            
            // 이미지 해금 여부에 따라 이미지 다르게 적용
            let imageName = (isUnlockedImage ? costumeNames[i] : costumeShadowNames[i])
            
            let imageTitle = costumeTitles[i]
            let imageExplain = costumeExplains[i]
            
            result.append(
                CostumeCell(cellNum: i,
                            imageName: imageName,
                            imageTitle: imageTitle,
                            imageExplain: imageExplain,
                            isUnlocked: isUnlockedImage)
            )
        }
        return result
    }
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State var selectNum: Int = 0
    
    var body: some View {
        VStack {
            CostumeGridView
        }
    }
    
    private var CostumeGridView: some View {
        
        return VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(cells) { cell in
                        CostumeCellView(cell: cell, isSheet: false, selectNum: $selectNum)
                    }
                }
            }
        }
    }
}

struct CostumeCellView: View {
    var cell: CostumeCell
    @State var isSheet: Bool
    @Binding var selectNum: Int
    
    var body: some View {
        
        VStack{
            Image("\(cell.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text("\(cell.imageTitle)")
            
            Text("\(selectNum == cell.cellNum ? "선택" : " ")")
            
        }
        .sheet(isPresented: $isSheet,
               content: {
            CostumeSheetView(cell: cell, selectNum: $selectNum, isSheet: $isSheet)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        .onTapGesture {
            isSheet = true
        }
    }
}

struct CostumeSheetView: View {
    var cell: CostumeCell
    @Binding var selectNum: Int
    @Binding var isSheet: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(
                    action: {
                        isSheet = false
                    },
                    label: {
                        Image(systemName: "x.circle.fill")
                            .padding()
                    }
                )
            }
            
            Text("\(cell.imageTitle)")
            Image("\(cell.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            Text("\(cell.imageExplain)")
            
            if cell.isUnlocked {
                Button(
                    action: {
                        selectCell()
                    },
                    label: {
                        Text("\(cell.cellNum) ")
                            .font(.title)
                        Text("\(selectNum == cell.cellNum ? "선택 취소" : "선택")")
                            .font(.title)
                    }
                )
            }else {
                Text("\(cell.cellNum) 를 선택할 수 없습니다.")
                    .font(.title)
            }
        }
    }
    
    private func selectCell() {
        selectNum = cell.cellNum
    }
}

struct CostumesBookView_Previews: PreviewProvider {
    static var previews: some View {
        CostumesBookView()
    }
}
