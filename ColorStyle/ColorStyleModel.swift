//
//  ColorStyleModel.swift
//  ColorStyle
//
//  Created by Xcode Developer on 5/4/24.
//

import Foundation
import Observation
import Combine
import SwiftUI

@Observable class ColorStyleModel  {
    var colorCount: Int = 12
    var colorSubCount: Int = 4
    var hueAngle: CGFloat = 9.0
    
    struct GradientStop: Identifiable {
        var hue: CGFloat
        var location: CGFloat
        var id = UUID()
    }
    
    func scale(oldMin: CGFloat, oldMax: CGFloat, value: CGFloat, newMin: CGFloat, newMax: CGFloat) -> CGFloat {
        return newMin + ((newMax - newMin) * ((value - oldMin) / (oldMax - oldMin)))
    }
    
    func scaleBatch(data: [Double], newMin: Double, newMax: Double) -> [Double] {
        guard let oldMin = data.min(), let oldMax = data.max(), oldMax != oldMin else { return data }
        return data.map { newMin + (newMax - newMin) * ($0 - oldMin) / (oldMax - oldMin)
        }
        
        func normalizeHueDegrees(hueDegrees: CGFloat, stepDegrees: CGFloat) -> CGFloat {
            let normalizedHue = (hueDegrees + stepDegrees).truncatingRemainder(dividingBy: 360.0)
            return normalizedHue < 0 ? (normalizedHue + 360) / 360 : normalizedHue / 360
        }
        
        // TODO: Create an array of hue values from a base hue at the center, evenly spaced between a range of degrees, starting with the hue of the lightest color to the hue of the darkest, with evenly divided intermediary hue values that increment/decrement from the min/max hue value to the base hue value.
        
        /*    Given the hue value of a base color in degrees, and given a value for range-bearing degrees, and given a color count, calculate the step (in degrees) between the hue value of each adjacent color, then return an array with the number of hue value elements that corresponds to the color count */
        
        //    var step: CGFloat = (1.0 / 12.0) //{ hue.scale(oldMin: 0.0, oldMax: 11.0 / 11.0, value: 1.0 / 12.0, newMin: 0.0, newMax: 1.0) }
        //    let locations: [Int] = Array<Int>(1..<12)
        //    var colora: [CGFloat]  { return (positions).map { Double($0) * step } }
        //
        //    var gradientStops: [Gradient.Stop] {
        //        zip(colors, locations).map { Gradient.Stop.init(color: color: $0, location: $1) }
        //    }
        
//        var gradientStops: [Gradient.Stop] {
//            [
//                Gradient.Stop(color: Color(hue: 246.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.0),
//                Gradient.Stop(color: Color(hue: 216.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 1.0),
//                Gradient.Stop(color: Color(hue: 216.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.0),
//                Gradient.Stop(color: Color(hue: 186.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 1.0),
//                Gradient.Stop(color: Color(hue: 186.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.0),
//                Gradient.Stop(color: Color(hue: 156.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 1.0)
//            ]
//        }
    }
}
