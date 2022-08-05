import UIKit

final class PetModuleDIContainer {
    
    struct Dependencies {
        let networkManager: NetworkManager
    }
    
    private let dependencies: Dependencies
        
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getPetmoduleFlow(navigationController: UINavigationController) -> PetModuleFlow {
        return PetModuleFlow(navigationController: navigationController, dependencies: self)
    }
}

extension PetModuleDIContainer: PetModuleFlowDependencies {
    
    func getPetListViewController(actionDelegate: PetListAction? = nil) -> PetListViewController {
        let petListVC = PetListViewController.instantiate()
        petListVC.viewModel = getPetListViewModel(actionDelegate: actionDelegate)
        return petListVC
    }
    
    func getPetListViewModel(actionDelegate: PetListAction? = nil) -> PetListViewModel {
        let petService = PetListNetworkServiceImpl(networkManager: dependencies.networkManager)
        let petListRepo = PetListRepositoryImplementation(networkService: petService)
        let petListUsecase =  PetListUseCaseImplementation(petListRepository: petListRepo)
        return PetListViewModelImplementation(petListUseCase: petListUsecase, actionDelegate: actionDelegate)
    }
    
    func getPetDetailViewController(model: PetInfoPresentationModel) -> PetDetailViewController {
        let petDetailVC = PetDetailViewController.instantiate()
        petDetailVC.viewModel = PetDetailViewModelImplementation(petInfo: model)
        return petDetailVC
    }
}
