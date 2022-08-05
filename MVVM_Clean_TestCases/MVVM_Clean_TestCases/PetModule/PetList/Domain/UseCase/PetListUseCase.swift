import Foundation

protocol PetListUseCase {
    func execute(completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void)
}
