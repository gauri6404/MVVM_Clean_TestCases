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
    
    func getPetListViewController(action: ((PetInfoPresentationModel) -> Void)?) -> PetListViewController {
        let petListVC = PetListViewController.instantiate()
        petListVC.viewModel = getPetListViewModel(action: action)
        return petListVC
    }
    
    func getPetListViewModel(action: ((PetInfoPresentationModel) -> Void)?) -> PetListViewModel {
        let petService = PetListNetworkServiceImpl(networkManager: dependencies.networkManager)
        let petListRepo = PetListRepositoryImplementation(networkService: petService)
        let petListUsecase =  PetListUseCaseImplementation(petListRepository: petListRepo)
        return PetListViewModelImplementation(petListUseCase: petListUsecase, showPetdetail: action)
    }
    
    func getPetDetailViewController(model: PetInfoPresentationModel) -> PetDetailViewController {
        let petDetailVC = PetDetailViewController.instantiate()
        petDetailVC.viewModel = PetDetailViewModelImplementation(petInfo: model)
        return petDetailVC
    }
}
