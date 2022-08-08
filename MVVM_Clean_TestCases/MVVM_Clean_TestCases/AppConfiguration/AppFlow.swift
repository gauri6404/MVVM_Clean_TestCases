import UIKit

final class AppFlow {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let petListDIContainer = appDIContainer.getPetListDIContainer()
        let flow = petListDIContainer.getPetListFlow(navigationController: navigationController)
        flow.start()
    }
}
