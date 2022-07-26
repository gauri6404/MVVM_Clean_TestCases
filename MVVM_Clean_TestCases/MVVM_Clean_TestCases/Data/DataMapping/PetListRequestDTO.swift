import Foundation

struct PetListRequestDTO: Encodable {
    var limit: Int
    
    enum CodingKeys: String, CodingKey {
        case limit
    }
}
