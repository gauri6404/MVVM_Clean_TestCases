import UIKit

class PetDetailViewController: UIViewController {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreedGroup: UILabel!
    @IBOutlet weak var petBreedFor: UILabel!
    @IBOutlet weak var petTemperment: UILabel!
    @IBOutlet weak var PetOrigin: UILabel!
    @IBOutlet weak var petLifeSpan: UILabel!
    
    var viewModel: PetDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPetDetailView()
    }
    
    private func setPetDetailView() {
        self.view.accessibilityIdentifier = PetModuleAccessibilityIdentifier.petDetail
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        self.title = viewModel.title
        self.petName.text = viewModel.petDetail.petName
        self.petBreedGroup.text = viewModel.petDetail.petBreedGroup
        self.petBreedFor.text = viewModel.petDetail.petBreed
        self.petTemperment.text = viewModel.petDetail.petTemperament
        self.PetOrigin.text = viewModel.petDetail.petOrigin
        self.petLifeSpan.text = viewModel.petDetail.petLifeSpan
    }
}
