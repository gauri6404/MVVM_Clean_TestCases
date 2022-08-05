import Foundation

protocol PetListNetworkService {
    func getPetListFromServer(completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void)
}

final class PetListNetworkServiceImpl: PetListNetworkService {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getPetListFromServer(completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void) {
        let endPointConfig = APIEndPoints.getPetList()
        self.networkManager.getAPIResponse(for: endPointConfig, returnType: [PetListResponseDTO].self) { result in
            switch result {
            case .success(let responseDTO):
                DispatchQueue.main.async {
                    completion(.success(responseDTO?.map({ responseDTO in
                        responseDTO.toDomain()
                    })))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
