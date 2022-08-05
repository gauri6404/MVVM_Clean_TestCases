import Foundation

protocol PetListUseCase {
    func execute(completion: @escaping (Result<[PetInfoPresentationModel]?, Error>) -> Void)
}
