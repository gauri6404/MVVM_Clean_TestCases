import Foundation

struct PetDetailItemViewModel {
    var petName: String?
    var petBreed: String?
    var petBreedGroup: String?
    var petLifeSpan: String?
    var petOrigin: String?
    var petTemperament: String?
}

extension PetDetailItemViewModel {

    init(pet: PetInfoPresentationModel) {
        self.petName = pet.name
        self.petBreed = pet.breed
        self.petBreedGroup = pet.breedGroup
        self.petLifeSpan = pet.lifeSpan
        self.petOrigin = pet.origin
        self.petTemperament = pet.temperament
    }
}
