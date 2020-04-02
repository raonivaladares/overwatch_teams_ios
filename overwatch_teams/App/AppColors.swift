import UIKit

struct AppColors {
    private init() {}
}

extension AppColors {
    private struct Reference {
        static var black: UIColor {
            .init(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        }
        
        static var grey: UIColor {
            .init(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.1)
        }
        
        static var whiteIce: UIColor {
            .init(red: 247/255, green: 248/255, blue: 249/255, alpha: 1)
        }
        
        static var whiteIceLight: UIColor {
            .init(red: 254/255, green: 255/255, blue: 255/255, alpha: 1)
        }
    }
    
    struct Components {
        static var labelText: UIColor {
            .init { (UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .dark ? .white : Reference.black
            }
        }
        
        static var imagePlaceHolder: UIColor {
            .init { (UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .dark ? .white : Reference.grey
            }
        }
        
        static var viewBackground: UIColor {
            .init { (UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .dark ? .black : Reference.whiteIce
            }
        }
        
        static var cellBackground: UIColor {
            .init { (UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .dark ? .black : Reference.whiteIceLight
            }
        }
        
        static var loader: UIColor {
            .init(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        }
    }
}

