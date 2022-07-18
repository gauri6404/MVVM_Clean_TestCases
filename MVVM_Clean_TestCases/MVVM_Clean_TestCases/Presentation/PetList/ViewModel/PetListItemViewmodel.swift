import Foundation

struct PetListItemViewModel {
    var identifier: Int?
    var name: String?
    var breed: String?
    var lifeSpan: String?
    var origin: String?
    var imageId: String?
    var imageURL: String?
}

extension PetListItemViewModel {

    init(pet: PetListResponseModel) {
        self.identifier = pet.identifier
        self.name = pet.name
        self.breed = pet.breed
        self.lifeSpan = pet.lifeSpan
        self.origin = pet.origin
        self.imageId = pet.image?.id
        self.imageURL = pet.image?.url
    }
}
