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
        self.networkManager.getAPIData(or: endPointConfig) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
