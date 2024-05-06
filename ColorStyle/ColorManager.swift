import Foundation
import Observation
import Combine
import SwiftUI

@Observable class ColorManager  {
//    @Environment(\.colorScheme) var colorScheme
    
    var colorCount: Int = 12
    var colorSubCount: Int = 2
    var hueAngle: CGFloat = 216.0
    var stepAngle: CGFloat { CGFloat(colorCount / colorSubCount) }
    
    func hueSystemColor() -> Color {
        return Color(hue: CGFloat(hueAngle / 360.0), saturation: 1.0, brightness: 1.0, opacity: 1.0)
    }
    
    func hueAccentColor(angle: CGFloat) -> Color {
        return Color(hue: CGFloat(angle / 360.0), saturation: 1.0, brightness: 1.0, opacity: 1.0)
    }
    
    func whiteColor() -> Color {
        return Color(.white)  //        return Color(hue: CGFloat(hueAngle / 360.0), saturation: 0.0, brightness: 1.0, opacity: 1.0)
        
    }
    
    func blackColor() -> Color {
        return Color(.black)  //        return Color(hue: CGFloat(hueAngle / 360.0), saturation: 0.0, brightness: 0.0, opacity: 1.0)
    }
    
    func getHueValue(color: Color) -> CGFloat {
        var hue: CGFloat = 0
        (UIColor(cgColor: color.cgColor.unsafelyUnwrapped)).getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        return hue
    }
    
    enum UserInterfaceStyleMode: Int {
        case unspecified = 0
        case light       = 1
        case dark        = 2
        case base        = 3
    }

    enum UserInterfaceStyleSource {
        case system
        case user(UserInterfaceStyleMode)
    }
    
    func userInterfaceStyleMode(source: Int) -> UserInterfaceStyleMode {
        var mode: Int {
            switch source {
            case 1:
                return UserInterfaceStyleMode.light.rawValue
            case 2:
                return UserInterfaceStyleMode.dark.rawValue
            default:
                return UserInterfaceStyleMode.unspecified.rawValue
            }
        }
        return UserInterfaceStyleMode(rawValue: mode) ?? UserInterfaceStyleMode.unspecified
    }


    func styleMode(source: UserInterfaceStyleSource) -> UserInterfaceStyleMode {
        var mode: Int {
            switch source {
            case .system:
                return UITraitCollection.current.userInterfaceStyle.rawValue
            case .user(let mode):
                return mode.rawValue
            }
        }
        return UserInterfaceStyleMode(rawValue: mode) ?? .light
    }

    var userInterfaceStyleSource: UserInterfaceStyleSource.Type = UserInterfaceStyleSource.self
    var userInterfaceStyleMode: UserInterfaceStyleMode.Type = UserInterfaceStyleMode.self
    
    func hueGradient(light: Color, dark: Color) -> [Color] {
        let hueValueLight: Int = Int(getHueValue(color: light))
        let hueValueDark: Int = Int(getHueValue(color: dark))
        return (hueValueLight...hueValueDark).map { hue in
            Color(hue: CGFloat(hue), saturation: 1.0, brightness: 1.0)
        }
    }
    
    /* Usage
     
    colorManager.opaqueHueColor(angle: 216.0, opacity: 0.5, userInterfaceStyleSource: ColorManager.UserInterfaceStyleSource.system)
    colorManager.opaqueHueColor(angle: 216.0, opacity: 0.5, userInterfaceStyleSource: ColorManager.UserInterfaceStyleSource.user(ColorManager.UserInterfaceStyleMode.dark))
    colorManager.opaqueHueColor(angle: 216.0, opacity: 0.5, userInterfaceStyleSource: ColorManager.UserInterfaceStyleSource.user(ColorManager.UserInterfaceStyleMode.light))
     
     */
    
//    func accentSystemColor() -> some View {
//        let currentStyle = UITraitCollection.current.userInterfaceStyle
//
//        return ((currentStyle == .dark) ? whiteColor().opacity(0.5) : blackColor().opacity(0.5))
//            .background {
//                accentColor(hueAngle: 216.0).opacity(1.0)
//            }
//            .overlay {
//                (currentStyle != .dark) ? whiteColor().opacity(0.5) : blackColor().opacity(0.5)
//            }
//    }

   
    //    func schemeColor() -> Color {
    //        let currentStyle = UITraitCollection.current.userInterfaceStyle
    //
    //        switch currentStyle {
    //        case .dark:
    //            // Assuming you want to adjust color settings for dark mode
    //            return blackColor()
    //        default:
    //            // Light mode and unspecified
    //            return whiteColor()
    //        }
    //    }
        
    
    
    struct GradientStop: Identifiable {
        var hue: CGFloat
        var location: CGFloat
        var id = UUID()
    }
    
    func scale(oldMin: CGFloat, oldMax: CGFloat, value: CGFloat, newMin: CGFloat, newMax: CGFloat) -> CGFloat {
        return newMin + ((newMax - newMin) * ((value - oldMin) / (oldMax - oldMin)))
    }
    
    func rotateHue(stepAngle: CGFloat) -> CGFloat {
           _hueAngle = (_hueAngle + stepAngle).truncatingRemainder(dividingBy: 360.0)
           return hueAngle < 0 ? (hueAngle + 360) / 360 : hueAngle / 360
       }
    
    func normalizeHueDegrees(hueAngle: CGFloat, stepAngle: CGFloat) -> CGFloat {
        let normalizedHue = (hueAngle + stepAngle).truncatingRemainder(dividingBy: 360.0)
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
    
    var gradientStops: [Gradient.Stop] {
        [
            Gradient.Stop(color: Color(hue: 236.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.0),
            Gradient.Stop(color: Color(hue: 216.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 1.0),
            Gradient.Stop(color: Color(hue: 216.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.3175),
            Gradient.Stop(color: Color(hue: 196.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.4125),
            Gradient.Stop(color: Color(hue: 196.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.6125),
            Gradient.Stop(color: Color(hue: 176.0 / 360.0, saturation: 1.0, brightness: 1.0), location: 0.875)
        ]
    }

}
