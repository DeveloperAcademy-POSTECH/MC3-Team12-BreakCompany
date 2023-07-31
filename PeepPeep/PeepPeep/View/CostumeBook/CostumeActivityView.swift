//
//  CostumeBookView.swift
//  DeviceActuvityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/18.
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

struct CostumeActivityView: View {
    
    // 이미지 해금 여부 리스트
    let isUnlockedImages = [
        true, true, true, true,
        true, true, true, true,
        true, true
    ]
    
    let costumeNames: Array = ["Classic","Newbie", "Apple", "Moon", "Cake", "Bag",  "Clover",  "Music" ]
    
    let costumeShadowNames: Array = ["BaseShadow","NewbieShadow","AppleShadow","MoonShadow","CakeShadow",  "BagShadow", "CloverShadow","MusicShadow"]
    
    let costumeTitles: [String] = [
        "클래식",
        "시작이 반이다",
        "얼리어답터",
        "한 달 살기",
        "우리 백 일이에요",
        "돌아온 탕아",
        "슬롯 머신",
        "무병 장수"
    ]
    
    let costumeExplains: [String] = [
        "기본으로 제공되는 병아리입니다.",
        "설정한 핸드폰 사용시간을\n1일 잘 지키면 지급됩니다.",
        "Apple Developer Academy\n발표날 앱을 설치하시면 지급됩니다.",
        "한 달 연속으로 핸드폰 목표 사용 시간을\n지켰을 때 지급됩니다.",
        "설정한 핸드폰 사용시간을 잘 지킨날이\n100일이 되면 지급됩니다.",
        "설정한 핸드폰 사용시간을 지키지 못해\n병아리가 처음 가출했을 때 지급됩니다.",
        "병아리의 스트레스 지수를 3일 연속으로\n33.3%로 유지했을 때 지급됩니다.",
        "설정한 핸드폰 사용시간을 일주일 연속으로\n잘 지켰을 때 지급됩니다."
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
    let mainActivity : Double
    @State var selectNum: Int = 0
//    @State private var isSheet = false
    
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
        .padding(.top, 45)
    }
}

struct CostumeCellView: View {
    var cell: CostumeCell
    @State var isSheet: Bool = false
    @Binding var selectNum: Int
    
    var body: some View {
        
        VStack{
            Image("\(cell.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 177, height: 177)
            Text("\(cell.imageTitle)")
                .font(.custom("DOSSaemmul", size: 16))
            
            
            HStack {
                Image(systemName: "checkmark")
                    .foregroundColor(selectNum == cell.cellNum ? .black : .white)
                    .font(.system(size: 10))
            }
            .frame(width: 30, height: 20, alignment: .center)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectNum == cell.cellNum ? .black : .white, lineWidth: 1)
            }
            
        }
        .sheet(isPresented: $isSheet,
               content: {
            CostumeSheetView(cell: cell, selectNum: $selectNum, isSheet: $isSheet)
                .presentationDetents([.fraction(0.6)])
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
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .symbolRenderingMode(.hierarchical)
                            .padding()
                    }
                )
                .padding(.trailing, 10)
            }
            ZStack {
                Text("\(cell.imageTitle)")
                    .offset( y: -100)
                    .font(.custom("DOSSaemmul", size: 20))
                Image("\(cell.imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 210, height: 210)
            }
            .padding(.bottom, 10)
            Text("\(cell.imageExplain)")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .frame(width: 400, height: 50)
                .font(.custom("DOSSaemmul", size: 16))
                .padding(.bottom, 10)
                .lineSpacing(3)
            
            Button {
                selectCell()
                isSheet = false
            } label: {
                Text("선택")
                    .font(.custom("DOSSaemmul", size: 20))
                    .frame(width: 100, height: 40, alignment: .center)
                    .foregroundColor(cell.isUnlocked && !(selectNum == cell.cellNum) ? .black : Color("LightGray"))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(cell.isUnlocked && !(selectNum == cell.cellNum) ? .black : Color("LightGray"),lineWidth: 1)
                    }
                    
            }
            .padding(.bottom, 20)
            .disabled(!(cell.isUnlocked && !(selectNum == cell.cellNum)))

        }
    }
    
    private func selectCell() {
        selectNum = cell.cellNum
    }
}
