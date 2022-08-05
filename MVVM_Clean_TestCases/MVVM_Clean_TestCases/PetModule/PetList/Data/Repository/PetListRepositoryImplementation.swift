import Foundation

final class PetListRepositoryImplementation {
    
    private let networkService: PetListNetworkService
    
    init(networkService: PetListNetworkService) {
        self.networkService = networkService
    }
}

extension PetListRepositoryImplementation: PetListRepository {
    func fetchPetList(completion: @escaping (Result<[PetInfoDomainModel]?, Error>) -> Void) {
        // TODO: Check from cache storage
        self.networkService.getPetListFromServer(completion: completion)
    }
}


