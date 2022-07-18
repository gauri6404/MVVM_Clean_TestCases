import Foundation

final class PetListUseCaseImplementation: PetListUseCase {
    private let petListRepository: PetListRepository

    init(petListRepository: PetListRepository) {
        self.petListRepository = petListRepository
    }

    func execute(requestValue: PetListUseCaseRequestValue, completion: @escaping (Result<PetListResponseModel?, Error>) -> Void) {
        return petListRepository.fetchPetList(page: requestValue.currentPageIndex, limit: requestValue.limit) { result in
            completion(result)
        }
    }
}

struct PetListUseCaseRequestValue {
    let currentPageIndex: Int
    let limit: Int
}
