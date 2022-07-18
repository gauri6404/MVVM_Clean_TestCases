import UIKit

protocol PetModuleFlowDependencies  {
    func getPetListViewController() -> PetListViewController
}

final class PetModuleFlow {
    private weak var navigationController: UINavigationController?
    private let dependencies: PetModuleFlowDependencies

    init(navigationController: UINavigationController, dependencies: PetModuleFlowDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.getPetListViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
