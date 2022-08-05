import UIKit

protocol PetModuleFlowDependencies  {
    func getPetListViewController(actionDelegate: PetListAction?) -> PetListViewController
    func getPetDetailViewController(model: PetInfoPresentationModel) -> PetDetailViewController
}

final class PetModuleFlow {
    private weak var navigationController: UINavigationController?
    private let dependencies: PetModuleFlowDependencies

    init(navigationController: UINavigationController, dependencies: PetModuleFlowDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.getPetListViewController(actionDelegate: self)
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension PetModuleFlow: PetListAction {
    func action_showPetdetail(for model: PetInfoPresentationModel) {
        let vc = dependencies.getPetDetailViewController(model: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
