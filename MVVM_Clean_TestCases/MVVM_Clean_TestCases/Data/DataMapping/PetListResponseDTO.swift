import Foundation

struct PetListResponseDTO: Decodable {
    var identifier: Int?
    var name: String?
    var breed: String?
    var lifeSpan: String?
    var origin: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name, origin
        case breed = "bred_for"
        case lifeSpan = "life_span"
    }
}

extension PetListResponseDTO {
    func toDomain() -> PetInfoModel {
        return .init(identifier: identifier, name: name, breed: breed, lifeSpan: lifeSpan, origin: origin)
    }
}
