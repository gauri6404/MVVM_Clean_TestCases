import Foundation

protocol PetListRepository {
    func fetchPetList(limit: Int, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void)
}
