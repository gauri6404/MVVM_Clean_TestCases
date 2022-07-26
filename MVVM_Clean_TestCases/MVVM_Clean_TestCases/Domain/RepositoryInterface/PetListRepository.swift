import Foundation

protocol PetListRepository {
    func fetchPetList(completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void)
}
