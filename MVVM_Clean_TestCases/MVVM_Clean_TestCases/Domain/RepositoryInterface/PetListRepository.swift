import Foundation

protocol PetListRepository {
    func fetchPetList(page: Int, limit: Int, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void)
}
