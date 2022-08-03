import Foundation

struct PetListResponseDTO: Decodable {
    var identifier: Int?
    var name: String?
    var breed: String?
    var lifeSpan: String?
    var origin: String?
    var breedGroup: String?
    var temperament: String?
    var image: PetImageModel?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name, origin, image, temperament
        case breed = "bred_for"
        case lifeSpan = "life_span"
        case breedGroup = "breed_group"
    }
}

struct PetImageModel: Decodable {
    var width: Int?
    var height: Int?
    var url: String?
}

extension PetListResponseDTO {
    func toDomain() -> PetInfoModel {
        return .init(identifier: identifier, name: name, breed: breed, lifeSpan: lifeSpan, origin: origin, breedGroup: breedGroup, temperament: temperament, imgURL: image?.url)
    }
}
