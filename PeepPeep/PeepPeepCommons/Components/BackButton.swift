//
//  BackButton.swift
//  PeepPeepCommons
//
//  Created by Ha Jong Myeong on 2023/07/25.
//

import Foundation
import SwiftUI

public struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    public init() {}

    public var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
        }
    }
}
