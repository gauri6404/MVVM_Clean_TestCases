import Foundation
import CoreText

protocol PetDetailViewModelOutput {
    var title: String { get }
    var petDetail: PetDetailItemViewModel { get }
}

protocol PetDetailViewModel: PetDetailViewModelOutput { }

final class PetDetailViewModelImplementation: PetDetailViewModel {
    
    var title: String {
        get {
            return "Pet Detail"
        }
    }
    
    let petDetail: PetDetailItemViewModel
        
    init(petInfo: PetInfoPresentationModel) {
        self.petDetail = .init(pet: petInfo)
    }
}
