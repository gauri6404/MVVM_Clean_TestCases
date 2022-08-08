import UIKit

final class PetListDIContainer {
    
    struct Dependencies {
        let networkManager: NetworkManager
    }
    
    private let dependencies: Dependencies
        
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getPetListFlow(navigationController: UINavigationController) -> PetListFlow {
        return PetListFlow(navigationController: navigationController, dependencies: self)
    }
}

extension PetListDIContainer: PetListFlowDependencies {
    
    func getPetListViewController() -> PetListViewController {
        let petListVC = PetListViewController.instantiate()
        petListVC.router = PetListRouterImplementation(source: petListVC)
        petListVC.viewModel = getPetListViewModel(actionDelegate: petListVC)
        return petListVC
    }
    
    func getPetListViewModel(actionDelegate: PetListAction? = nil) -> PetListViewModel {
        let petService = PetListNetworkServiceImpl(networkManager: dependencies.networkManager)
        let petListRepo = PetListRepositoryImplementation(networkService: petService)
        let petListUsecase =  PetListUseCaseImplementation(petListRepository: petListRepo)
        return PetListViewModelImplementation(petListUseCase: petListUsecase, actionDelegate: actionDelegate)
    }
}
