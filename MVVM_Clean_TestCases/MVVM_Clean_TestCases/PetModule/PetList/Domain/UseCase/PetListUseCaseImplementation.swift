import Foundation

final class PetListUseCaseImplementation: PetListUseCase {
    private let petListRepository: PetListRepository

    init(petListRepository: PetListRepository) {
        self.petListRepository = petListRepository
    }

    func execute(completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void) {
        return petListRepository.fetchPetList() { result in
            completion(result)
        }
    }
}
