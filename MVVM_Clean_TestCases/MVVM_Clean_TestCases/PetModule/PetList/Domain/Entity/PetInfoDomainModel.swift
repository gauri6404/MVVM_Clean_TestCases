import Foundation

struct PetInfoDomainModel: Equatable {
    var identifier: Int?
    var name: String?
    var breed: String?
    var lifeSpan: String?
    var origin: String?
    var breedGroup: String?
    var temperament: String?
    var imgURL: String?
}

extension PetInfoDomainModel {
    func toPresentation() -> PetInfoPresentationModel {
        return .init(identifier: identifier, name: name, breed: breed, lifeSpan: lifeSpan, origin: origin, breedGroup: breedGroup, temperament: temperament, imgURL: imgURL)
    }
}
