import Foundation
import CoreText

protocol PetDetailViewModelOutput {
    var title: String { get }
    var petDetail: PetDetailItemViewModel { get }
}

protocol PetDetailViewModel: PetDetailViewModelOutput { }

final class PetDetailViewModelImplementation: PetDetailViewModel {
    
    let title: String
    let petDetail: PetDetailItemViewModel
        
    init(petInfo: PetInfoModel) {
        self.title = "Pet Detail"
        self.petDetail = .init(pet: petInfo)
    }
}
