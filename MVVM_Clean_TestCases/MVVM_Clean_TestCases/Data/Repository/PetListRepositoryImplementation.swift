import Foundation

final class PetListRepositoryImplementation {
    
    private let networkService: PetListNetworkService
    
    init(networkService: PetListNetworkService) {
        self.networkService = networkService
    }
}

extension PetListRepositoryImplementation: PetListRepository {
    func fetchPetList(limit: Int, completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void) {
        self.networkService.getPetListFromServer(limit: limit, completion: completion)
    }
}


