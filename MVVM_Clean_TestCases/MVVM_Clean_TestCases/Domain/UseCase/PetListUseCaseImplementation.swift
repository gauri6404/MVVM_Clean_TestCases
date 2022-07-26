import Foundation

final class PetListUseCaseImplementation: PetListUseCase {
    private let petListRepository: PetListRepository

    init(petListRepository: PetListRepository) {
        self.petListRepository = petListRepository
    }

    func execute(requestValue: PetListUseCaseRequestValue, completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void) {
        return petListRepository.fetchPetList(limit: requestValue.limit) { result in
            completion(result)
        }
    }
}
