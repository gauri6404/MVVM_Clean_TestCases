import Foundation

struct PetRequestModel: Encodable {
    var limit: Int
    
    enum CodingKeys: String, CodingKey {
        case limit
    }
}
