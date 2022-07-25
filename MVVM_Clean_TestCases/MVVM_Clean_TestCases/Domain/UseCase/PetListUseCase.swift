import Foundation

protocol PetListUseCase {
    func execute(requestValue: PetListUseCaseRequestValue, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void)
}

struct PetListUseCaseRequestValue {
    let limit: Int
}
