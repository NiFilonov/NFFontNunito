import UIKit

extension UIFont {
    
    public static func registerNunito() {
        NunitoStyle.allCases.forEach { style in
            UIFont.registerFont(
                withFilenameString: style.filename,
                bundle: .main
            )
        }
    }
    
    public enum NunitoStyle: String, CaseIterable {
        case black = "Black"
        case blackItalic = "BlackItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case extraBold = "ExtraBold"
        case extraBoldItalic = "ExtraBoldItalic"
        case extraLight = "ExtraLight"
        case extraLightItalic = "ExtraLightItalic"
        case italic = "Italic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case regular = "Regular"
        case semiBold = "SemiBold"
        case semiBoldItalic = "SemiBoldItalic"

        private var fontName: String {
            return "Nunito"
        }

        fileprivate var name: String {
            return "\(fontName)-\(rawValue)"
        }
        
        fileprivate var filename: String {
            return "\(fontName)-\(rawValue).ttf"
        }
    }

    public static func nunito(ofSize: CGFloat, style: NunitoStyle = .regular) -> UIFont {
        guard let font = UIFont(name: style.name, size: ofSize) else {
            fatalError()
        }
        return font
    }
    
}


public extension UIFont {

    public static func registerFont(withFilenameString filenameString: String, bundle: Bundle) {

        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("UIFont+:  Failed to register font - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

}
