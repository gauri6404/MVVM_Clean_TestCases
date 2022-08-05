import Foundation

protocol PetListRepository {
    func fetchPetList(completion: @escaping (Result<[PetInfoDomainModel]?, Error>) -> Void)
}
