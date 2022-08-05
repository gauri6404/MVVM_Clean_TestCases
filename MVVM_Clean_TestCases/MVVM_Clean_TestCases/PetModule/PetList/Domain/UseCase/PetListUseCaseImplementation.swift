import Foundation

final class PetListUseCaseImplementation: PetListUseCase {
    private let petListRepository: PetListRepository
    
    init(petListRepository: PetListRepository) {
        self.petListRepository = petListRepository
    }
    
    func execute(completion: @escaping (Result<[PetInfoPresentationModel]?, Error>) -> Void) {
        return petListRepository.fetchPetList() { result in
            switch result {
            case .success(let petInfoDomainModelList):
                completion(.success(petInfoDomainModelList?.map({ petInfoDomainModel in
                    petInfoDomainModel.toPresentation()
                })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
