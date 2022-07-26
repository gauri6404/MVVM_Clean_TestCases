import Foundation

protocol PetListUseCase {
    func execute(requestValue: PetListUseCaseRequestValue, completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void)
}

struct PetListUseCaseRequestValue {
    let limit: Int
}
