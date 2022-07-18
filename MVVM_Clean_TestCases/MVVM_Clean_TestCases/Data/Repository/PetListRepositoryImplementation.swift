import Foundation

final class PetListRepositoryImplementation {

    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension PetListRepositoryImplementation: PetListRepository {
    func fetchPetList(page: Int, limit: Int, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void) {
        let endPointConfig = APIEndpoints.getPetList(with: PetRequestModel(currentPageIndex: page, limit: limit))
        self.networkManager.getAPIResponse(for: endPointConfig, returnType: [PetListResponseModel].self) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
