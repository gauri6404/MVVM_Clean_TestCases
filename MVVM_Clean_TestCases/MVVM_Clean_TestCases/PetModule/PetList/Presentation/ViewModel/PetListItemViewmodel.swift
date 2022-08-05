import Foundation

struct PetListItemViewModel {
    var identifier: Int?
    var name: String?
    var breed: String?
    var lifeSpan: String?
    var origin: String?
}

extension PetListItemViewModel {

    init(pet: PetInfoPresentationModel) {
        self.identifier = pet.identifier
        self.name = pet.name
        self.breed = pet.breed
        self.lifeSpan = pet.lifeSpan
        self.origin = pet.origin
    }
}
