//
//  CustomSpacer.swift
//  PeepPeepCommons
//
//  Created by Ha Jong Myeong on 2023/07/26.
//

import SwiftUI

public struct CustomSpacer: View {
    public var height: CGFloat

    public init(height: CGFloat) {
        self.height = height
    }

    public var body: some View {
        Spacer()
            .frame(height: height)
    }
}
