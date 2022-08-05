import UIKit

protocol PetModuleFlowDependencies  {
    func getPetListViewController(action: ((PetInfoPresentationModel) -> Void)?) -> PetListViewController
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
        let vc = dependencies.getPetListViewController(action: showPetDetail(model:))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showPetDetail(model: PetInfoPresentationModel) {
        let vc = dependencies.getPetDetailViewController(model: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
