import UIKit

protocol Storyboardable {
    static var storyboardName: String { get }
    static var fileIdentifier: String { get }
    static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }
    
    static var fileIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: fileIdentifier) as? Self else {
            fatalError("Unable to Instantiate View Controller With Storyboard Identifier \(fileIdentifier)")
        }
        return viewController
    }
}
