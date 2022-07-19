import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDIContainer = AppDIContainer()
    var appFlow: AppFlow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        appFlow = AppFlow(navigationController: navigationController, appDIContainer: appDIContainer)
        appFlow?.start()
        window?.makeKeyAndVisible()
        return true
    }
}

