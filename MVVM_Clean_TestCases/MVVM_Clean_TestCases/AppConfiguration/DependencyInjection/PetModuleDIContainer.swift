import UIKit

final class PetModuleDIContainer {
    
    struct Dependencies {
        let networkManager: NetworkManager
        let imageNetworkManager: NetworkManager
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
        let petImgRepo = PetImageRepositoryImplementation(networkManager: dependencies.imageNetworkManager)
        return PetListViewController.create(with: getPetListViewModel(), petImagesRepository: petImgRepo)
    }
    
    func getPetListViewModel() -> PetListViewModel {
        let petListRepo = PetListRepositoryImplementation(networkManager: dependencies.networkManager)
        let petListUsecase =  PetListUseCaseImplementation(petListRepository: petListRepo)
        return PetListViewModelImplementation(petListUseCase: petListUsecase)
    }
}
