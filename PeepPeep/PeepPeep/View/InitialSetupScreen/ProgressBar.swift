//
//  ProgressBar.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/26.
//
import SwiftUI

struct ProgressBar: View {
    var currentStep: Int
    var endStep: Int = 4
    var activeColor: Color = .black
    var inactiveColor: Color = Color.gray.opacity(0.5)
    var sectionWidth: CGFloat = 60

    var body: some View {
        HStack {
            Spacer()
            HStack(alignment: .center, spacing: 4) {
                ForEach(0..<endStep, id: \.self) { index in
                    Rectangle()
                        .fill(index < currentStep ? activeColor : inactiveColor)
                        .frame(width: sectionWidth)
                }
            }
            Spacer()
        }
        .frame(height: 10)
    }
}
