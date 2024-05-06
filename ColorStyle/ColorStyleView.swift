import SwiftUI
import Observation
import Combine

struct ColorStyleView: View {
    @State private var colorManager = ColorManager()
    @Environment(\.colorScheme) private var colorScheme

    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    GeometryReader { geometry in
                        HueColorWheel(colorManager: colorManager, frameSize: CGSize(width: (geometry.size.width), height: (geometry.size.height)), indicatorSize: CGSizeMake(30.0, 30.0))
                    }
                }
                VStack {
                    
                }
                VStack {
                    
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2)
            
            
            HStack {
                VStack {
                    HStack {
                        VStack {
                            ZStack {
                                OpaqueHueColorView(colorManager: colorManager, angle: colorManager.hueAngle, opacity: 0.5, mode: colorManager.userInterfaceStyleMode(source: colorScheme.userInterfaceStyleModeValue))
                                Text((colorScheme.userInterfaceStyleModeValue == 1) ? ("SYSTEM.LIGHT") : ("SYSTEM.DARK"))
                                    .foregroundStyle((colorScheme.userInterfaceStyleModeValue == 1) ? .black : .white)
                                    .font(.caption).dynamicTypeSize(.xSmall)
                            }
                            
                            HStack {
                                ZStack {
                                    OpaqueHueColorView(colorManager: colorManager, angle: colorManager.hueAngle, opacity: 0.5, mode: ColorManager.UserInterfaceStyleMode.light)
                                    Text("SYSTEM.LIGHT")
                                        .foregroundStyle(.black)
                                        .font(.caption).dynamicTypeSize(.xSmall)
                                }
                                ZStack {
                                    OpaqueHueColorView(colorManager: colorManager, angle: colorManager.hueAngle, opacity: 0.5, mode: ColorManager.UserInterfaceStyleMode.dark)
                                    Text("SYSTEM.DARK")
                                        .foregroundStyle(.white)
                                        .font(.caption).dynamicTypeSize(.xSmall)
                                }
                                
                               
                            }
                            //                            HStack {
                            //                                ForEach(1...($colorManager.colorCount.wrappedValue / 3), id: \.self) { count in
                            //                                    colorManager.opaqueHueColor(angle: CGFloat(colorManager.hueAngle), opacity: 0.5 - (0.5 - CGFloat(4.0 - Double(count)) / 4.0), userInterfaceStyleSource: ColorManager.UserInterfaceStyleSource.user(ColorManager.UserInterfaceStyleMode.light))
                            //                                }
                            //                                ForEach(1...($colorManager.colorCount.wrappedValue / 2), id: \.self) { count in
                            //                                    colorManager.opaqueHueColor(angle: CGFloat(colorManager.hueAngle), opacity: (0.5 - (CGFloat(4.0 - Double(count))) / 4.0), userInterfaceStyleSource: ColorManager.UserInterfaceStyleSource.user(ColorManager.UserInterfaceStyleMode.dark))
                            //                                }
                            //                                LinearGradient(colors: [colorManager.opaqueHueColor(angle: colorManager.hueAngle, opacity: 0.5, userInterfaceStyleSource: ColorManager.UserInterfaceStyleSource.user(ColorManager.UserInterfaceStyleMode.light)),
                            //                                                        colorManager.opaqueHueColor(angle: colorManager.hueAngle, opacity: 0.5, userInterfaceStyleSource: ColorManager.UserInterfaceStyleSource.user(ColorManager.UserInterfaceStyleMode.dark))],
                            //                                               startPoint: .leading, endPoint: .trailing)
                            //
                            //                            }
                            
                        }
                    }
                }
            }
            
            HStack {
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 0.25, brightness: 1.0, opacity: 1.0))
                
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 0.6125, brightness: 0.6125, opacity: 1.0))
                
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 1.0, brightness: 0.25, opacity: 1.0))
                
            }
            
            HStack {
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 0.25, brightness: 1.0, opacity: 1.0))
                
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 0.6125, brightness: 0.6125, opacity: 1.0))
                
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 1.0, brightness: 0.25, opacity: 1.0))
                
            }
            
            HStack {
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 0.25, brightness: 1.0, opacity: 1.0))
                
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 0.6125, brightness: 0.6125, opacity: 1.0))
                
                Color(Color(hue: CGFloat(216.0 / 360.0), saturation: 1.0, brightness: 0.25, opacity: 1.0))
            }
        }
    }
}


extension ColorScheme {
    var userInterfaceStyleModeValue: Int {
        switch self {
        case .light:
            return 1
        case .dark:
            return 2
        @unknown default:
            return 0 // Default to light mode or a sensible default
        }
    }
}




                         
struct OpaqueHueColorView: View {
    @Bindable var colorManager: ColorManager
    let angle: CGFloat
    let opacity: CGFloat
    let mode: ColorManager.UserInterfaceStyleMode
    
    var body: some View {
        ZStack {
            ((mode == ColorManager.UserInterfaceStyleMode.light)
            ? colorManager.whiteColor().opacity(opacity)
            : colorManager.blackColor().opacity(opacity))
            .background {
                colorManager.hueAccentColor(angle: angle)
            }
            .overlay {
                ((mode == ColorManager.UserInterfaceStyleMode.light)
                ? colorManager.whiteColor().opacity(opacity)
                : colorManager.blackColor().opacity(opacity))
            }
//            .background { colorManager.hueAccentColor(angle: angle) }
//                .overlay { (colorManager.styleMode(source: source) == colorManager.userInterfaceStyleMode.light)
//                    ? colorManager.whiteColor().opacity(0.5)
//                    : colorManager.blackColor().opacity(0.5)) }
//            colorManager.whiteColor().opacity(opacity)
        }
//        .background {
//            colorManager.hueAccentColor(angle: angle)
//        }
//        .overlay {
//            colorManager.blackColor().opacity(opacity)
//        }
    }
}


struct HueColorWheel: View {
    @Bindable var colorManager: ColorManager
    var frameSize: CGSize
    var indicatorSize: CGSize = CGSize(width: 30.0, height: 30.0)
    let minimumValue: CGFloat = 0.0
    let maximumValue: CGFloat = 359.0
    let totalValue: CGFloat = 360.0
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        GeometryReader { geometry in
            let radius: CGFloat = (geometry.size.width > geometry.size.height) ? (geometry.size.height / 2) : (geometry.size.width / 2)
            var _diameter: CGSize = geometry.size
            var diameter: CGSize {
                get { return _diameter }
                set { _diameter = newValue }
            }
            
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                // Wheel
                Circle()
                    .strokeBorder(
                        AngularGradient(gradient: .init(colors: hueColors()), center: .center),
                        lineWidth: indicatorSize.width + 8.0)
                    .contentShape(Circle())
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .rotationEffect(.degrees(-90))
                    .overlay {
                        Text(String(format: "%.0f°", CGFloat($colorManager.hueAngle.wrappedValue)))                .
                        font(.largeTitle)
                            .foregroundStyle(colorManager.hueSystemColor())
                            .aspectRatio(geometry.size.width / geometry.size.height, contentMode: .fill)
                    }
                    .frame(width: geometry.size.width, height: frameSize.height)
                
                // Spoke
                Circle()
                    .foregroundStyle(.linearGradient(colors: [
                        Color(hue: CGFloat(colorManager.normalizeHueDegrees(hueAngle: colorManager.hueAngle, stepAngle: -27.125)), saturation: 1.0, brightness: 1.0, opacity: 1.0),
                        Color(hue: CGFloat(colorManager.normalizeHueDegrees(hueAngle: colorManager.hueAngle, stepAngle:   0.00)), saturation: 1.0, brightness: 1.0, opacity: 1.0),
                        Color(hue: CGFloat(colorManager.normalizeHueDegrees(hueAngle: colorManager.hueAngle, stepAngle:  27.125)), saturation: 1.0, brightness: 1.0, opacity: 1.0)],
                                                     startPoint: .leading, endPoint: .trailing))
                    .shadow(color: .black, radius: 7.5)
                    .frame(width: indicatorSize.width - 1.0, height: indicatorSize.height - 1.0)
                    .offset(y: (-(radius - ((frameSize.width < frameSize.height) ? (indicatorSize.height / 2) : (indicatorSize.width / 2)))) + 4.0)
//                    .clipShape(Circle().offset(y: (-(radius - ((frameSize.width < frameSize.height) ? (indicatorSize.height / 2) : (indicatorSize.width / 2)))) + 4.0))
                    .rotationEffect(Angle.degrees(CGFloat(colorManager.hueAngle).rounded()))
                    .gesture(DragGesture(minimumDistance: 0.0)
                        .onChanged({ value in
                            change(location: value.location)
                            feedbackGenerator.impactOccurred()
                        }))
            })
        }
    }
    
    func hueColors() -> [Color] {
        (0...360).map { i in
            Color(hue: (CGFloat(i) / 360.0), saturation: 1.0, brightness: 1.0)
        }
    }
    
    func brightnessGradientColors(min: Int, max: Int) -> [Color] {
        (min...max).map { i in
            Color(hue: CGFloat(colorManager.hueAngle) / 360.0, saturation: 1.0, brightness: CGFloat(i) / 100.0)
        }
    }
    
    private func change(location: CGPoint) {
        // creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
        
        // geting angle in radian need to subtract the knob radius and padding from the dy and dx
        let angle = atan2(vector.dy - (indicatorSize.width), vector.dx - (indicatorSize.width)) + .pi/2.0
        
        // convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // convert angle value to temperature value
        let value = fixedAngle / (2.0 * .pi) * totalValue
        
        if minimumValue >= 0.0 && maximumValue <= 360.0 {
            colorManager.hueAngle = CGFloat(fixedAngle * 180 / .pi) // converting to degrees
        }
    }
}


struct SapphireColorView: View {
    var body: some View {
        Color(hue: 216.0 / 360.0, saturation: 0.3333, brightness: 0.3333)
    }
}

struct ColorView: View {
    @Bindable var colorManager: ColorManager
    var containerSize: CGSize
    
    var body: some View {
        HStack {
            ForEach(1...$colorManager.colorCount.wrappedValue, id: \.self) { count in
                GeometryReader { geometry in
                    LinearGradient(
                        colors: [
                            Color(hue: colorManager.rotateHue(stepAngle: colorManager.stepAngle), saturation: 1, brightness: 1.0),
                            Color(hue: colorManager.rotateHue(stepAngle: colorManager.stepAngle), saturation: 1, brightness: 1.0)],
                        startPoint: .top, endPoint: .bottom)
                    .overlay {
                        Text("\(count)")
                            .font(.system(size: (geometry.size.width + geometry.size.height) / 6, weight: .black, design: .default))
                            .foregroundStyle(.white.opacity(0.15))
                        
                    }
                }
                .aspectRatio(1.0, contentMode: .fit)
                .shadow(color: .black.opacity(0.25), radius: 6.0, x: 3.0, y: 3.0)
            }
        }
    }
}

struct ColorStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorStyleView()
//                    .preferredColorScheme(.dark)
        //            .ignoresSafeArea()
    }
}

struct HueOpacityColorView: View {
    var colorManager: ColorManager
    var foregroundColor: Color
    var backgroundColor: Color
    var opacity: CGFloat
    
    var body: some View {
        Color(Color(hue:   CGFloat(216.0 / 360.0), saturation: 1.0, brightness: 1.0, opacity: 0.25))
            .background {
                Color(hue: CGFloat(216.0 / 360.0),
                      saturation: 0.0,
                      brightness: 1.0,
                      opacity: 1.0)
            }
    }
}
