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
    func getPetListViewController() -> PetListViewController {
        let petListVC = UIStoryboard(name: "PetListStoryboard", bundle: nil).instantiateViewController(withIdentifier: String(describing: PetListViewController.self)) as! PetListViewController
        petListVC.viewModel = getPetListViewModel()
        return petListVC
    }
    
    func getPetListViewModel() -> PetListViewModel {
        let petService = PetListNetworkServiceImpl(networkManager: dependencies.networkManager)
        let petListRepo = PetListRepositoryImplementation(networkService: petService)
        let petListUsecase =  PetListUseCaseImplementation(petListRepository: petListRepo)
        return PetListViewModelImplementation(petListUseCase: petListUsecase)
    }
}
