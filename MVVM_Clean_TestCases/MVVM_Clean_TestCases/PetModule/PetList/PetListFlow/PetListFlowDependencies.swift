import UIKit

protocol PetListFlowDependencies  {
    func getPetListViewController() -> PetListViewController
}

final class PetListFlow {
    private weak var navigationController: UINavigationController?
    private let dependencies: PetListFlowDependencies

    init(navigationController: UINavigationController, dependencies: PetListFlowDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.getPetListViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
