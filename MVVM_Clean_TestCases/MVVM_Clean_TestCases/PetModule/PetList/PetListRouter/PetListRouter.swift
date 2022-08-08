import UIKit

protocol PetListRouter: AnyObject {
    func action_showPetdetail(for model: PetInfoPresentationModel)
}

final class PetListRouterImplementation {
    private var source: UIViewController?
    
    init(source: UIViewController?) {
        self.source = source
    }
}

extension PetListRouterImplementation: PetListRouter {
    func action_showPetdetail(for model: PetInfoPresentationModel) {
        let petDetailVC = PetDetailViewController.instantiate()
        petDetailVC.viewModel = PetDetailViewModelImplementation(petInfo: model)
        self.source?.navigationController?.pushViewController(petDetailVC, animated: true)
    }
}
