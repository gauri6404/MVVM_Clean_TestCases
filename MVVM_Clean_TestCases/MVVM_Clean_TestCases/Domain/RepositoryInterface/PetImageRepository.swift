import Foundation

protocol PetImageRepository {
    func fetchImage(with imagePath: String, completion: @escaping (Result<Data?, Error>) -> Void)
}
