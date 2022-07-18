import UIKit

final class AppFlow {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let petmoduleDIContainer = appDIContainer.getPetModuleDIContainer()
        let flow = petmoduleDIContainer.getPetmoduleFlow(navigationController: navigationController)
        flow.start()
    }
}
