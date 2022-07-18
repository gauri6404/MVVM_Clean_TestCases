import Foundation

final class PetImageRepositoryImplementation {
    
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension PetImageRepositoryImplementation: PetImageRepository {
    func fetchImage(with imagePath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        let endPointConfig = APIEndpoints.getPetimage(path: imagePath)
        self.networkManager.getAPIResponse(for: endPointConfig, returnType: Data.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
