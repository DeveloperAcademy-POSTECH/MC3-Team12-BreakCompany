//
//  PieChartView.swift
//  DeviceActivityReportExtension
//
//  Created by Ha Jong Myeong on 2023/07/25.
//
import SwiftUI

struct PieChartView: View {
    /// 차트 데이터에 해당합니다.
    let data: [(Double, Color)]

    var body: some View {
        GeometryReader { geometry in
            let diameter = min(geometry.size.width, geometry.size.height) * 0.7
            HStack {
                Spacer()
                ZStack {
                    Canvas { context, size in
                        drawPieSlice(context: context, size: size)
                    }
                    .aspectRatio(1, contentMode: .fit)
                    Circle()
                        .fill(Color.white)
                        .frame(width: diameter, height: diameter, alignment: .center)
                }
                Spacer()
            }
        }
    }

    /// 중심을 기준으로 반지름에 따른 원을 그리고, 각각의 파이 슬라이스를 색상에 맞게 채웁니다.
    private func drawPieSlice(context: GraphicsContext, size: CGSize) {
        let total = data.reduce(0) { $0 + $1.0 }
        let radius = min(size.width, size.height) * 0.4
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.5)

        var startAngle = Angle.zero
        for (value, color) in data {
            let angle = Angle(degrees: 360 * (value / total))
            let endAngle = startAngle + angle - Angle(degrees: 1)
            let path = Path { path in
                path.move(to: center)
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                path.closeSubpath()
            }
            context.fill(path, with: .color(color))
            startAngle = endAngle + Angle(degrees: 1)
        }
    }
}
