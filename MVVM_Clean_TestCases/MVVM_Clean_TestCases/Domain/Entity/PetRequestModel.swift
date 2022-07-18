import Foundation

struct PetRequestModel: Encodable {
    var currentPageIndex: Int
    var limit: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPageIndex = "page"
        case limit
    }
}
