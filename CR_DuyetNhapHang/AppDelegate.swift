//
//  AppDelegate.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 07/10/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            let navigationBar = UINavigationBar()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.backgroundColor = Color.mainColor
            navigationBar.standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().tintColor = .white
        }else {
            UINavigationBar.appearance().barTintColor = Color.mainColor
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

struct Color {
    static let mainColor:UIColor = .systemBlue
}

class Animation {

    static func reload(collectionView:UICollectionView,animationDirection:String) {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        let cells = collectionView.visibleCells
        var index = 0
        let tableHeight: CGFloat = collectionView.bounds.size.height
        for i in cells {
            let cell: UICollectionViewCell = i as UICollectionViewCell
            switch animationDirection {
            case "up":
                cell.transform = CGAffineTransform(translationX: 0, y: -tableHeight)
                break
            case "down":
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
                break
            case "left":
                cell.transform = CGAffineTransform(translationX: tableHeight, y: 0)
                break
            case "right":
                cell.transform = CGAffineTransform(translationX: -tableHeight, y: 0)
                break
            default:
                cell.transform = CGAffineTransform(translationX: tableHeight, y: 0)
                break
            }
            UIView.animate(withDuration: 1.0, delay: 0.02 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
    }
}

class AnimationUtility: UIViewController, CAAnimationDelegate {

    static let kSlideAnimationDuration: CFTimeInterval = 0.4

    static func viewSlideInFromRight(toLeft views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromRight
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromLeft(toRight views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromLeft
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromTop(toBottom views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromBottom
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromBottom(toTop views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromTop
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }
}

extension String {
    func IPV4isValidate() -> Bool {
        var sin = sockaddr_in()
        return self.withCString({ cstring in inet_pton(AF_INET, cstring, &sin.sin_addr) }) == 1
    }
}

struct URLs {
#if DEBUG
    static let domainAddIP3G = "http://mpharmacyservicebeta.fptshop.com.vn:8085/mPharmacy/Service.svc/"
    static let main = "http://mpharmacyservicebeta.fptshop.com.vn:8082/mPharmacy/Service.svc/"
#else
    static let domainAddIP3G = "http://mpharmacyservicebeta.fptshop.com.vn:8085/mPharmacy/Service.svc/"
    static let main = "http://mpharmacyservicebeta.fptshop.com.vn:8082/mPharmacy/Service.svc/"
#endif
}

struct DataUserLogin {
    static var s_Email: String! = ""
}

struct Helper {
    static func getUUID() -> String? {
        let uuid = UUID().uuidString + "dungdtk3"
        return uuid
    }
    
    static func getShopName() -> String?{
        return "80012 - LC HCM 169 Phạm Hữu Lầu"
    }
    
    static func getShopCode() -> String?
    {
        let def = UserDefaults.standard
        return def.object(forKey: "ShopCode") as? String
        
    }
    
    static func getUserCode() -> String? {
        return "0091"
    }

}


struct LoadEmailModel: Decodable {
    let loadEmailUser: [EmailUser]
    
    enum CodingKeys: String, CodingKey {
        case loadEmailUser = "Load_Email_User"
    }
}

struct EmailUser: Decodable {
    let email, name, userName: String
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case name = "Name"
        case userName = "UserName"
    }
}

class SharedCommons {
    
    static let shared = SharedCommons()
    
    private init(){
        
    }
    
    func timeHoursString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func timeMinutesString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i",minutes, seconds)
    }
    
    func convertCurrencyString(currency:Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: currency))!
    }
    
    func convertCurrencyStringWithCurrencyUnit(currency:Int,currencyUnit:String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: currencyUnit)
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: currency))!
    }
}

extension UIColor {
    convenience init(HexString: String) {
        let hex = HexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
