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
    
    // MARK: - Repositories
    func getPetListRepository() -> PetListRepository {
        return PetListRepositoryImplementation(networkManager: dependencies.networkManager)
    }

    func getPetImagesRepository() -> PetImageRepository {
        return PetImageRepositoryImplementation(networkManager: dependencies.networkManager)
    }
    
    // MARK: - Use Cases
    func getPetListUseCase() -> PetListUseCase {
        return PetListUseCaseImplementation(petListRepository: getPetListRepository())
    }
    
    // MARK: - Flow Coordinators
    func getPetmoduleFlow(navigationController: UINavigationController) -> PetModuleFlow {
        return PetModuleFlow(navigationController: navigationController, dependencies: self)
    }
}

extension PetModuleDIContainer: PetModuleFlowDependencies {
    func getPetListViewController() -> PetListViewController {
        return PetListViewController.create(with: getPetListViewModel(), petImagesRepository: getPetImagesRepository())
    }
    
    func getPetListViewModel() -> PetListViewModel {
        return PetListViewModelImplementation(petListUseCase: getPetListUseCase())
    }
}
