import Foundation

protocol PetListRepository {
    func fetchPetList(limit: Int, completion: @escaping (Result<[PetInfoModel]?, Error>) -> Void)
}
