import Foundation

struct PetListResponseModel: Decodable {
    var identifier: Int?
    var name: String?
    var breed: String?
    var lifeSpan: String?
    var origin: String?
    var image: PetImageDataModel?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name, origin, image
        case breed = "bred_for"
        case lifeSpan = "life_span"
    }
}

struct PetImageDataModel: Decodable {
    var id: String?
    var url: String?
}

struct PetPage {
    var page: Int
    var totalPetCount: Int
    var petList: [PetListResponseModel]
}
