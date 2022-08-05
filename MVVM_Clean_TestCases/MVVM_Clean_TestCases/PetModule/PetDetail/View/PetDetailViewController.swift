import UIKit

class PetDetailViewController: UIViewController, Storyboardable {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreedGroup: UILabel!
    @IBOutlet weak var petBreedFor: UILabel!
    @IBOutlet weak var petTemperment: UILabel!
    @IBOutlet weak var PetOrigin: UILabel!
    @IBOutlet weak var petLifeSpan: UILabel!
    
    var viewModel: PetDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIdentifier()
        setNavigationBar()
        setPetDetailView()
    }
    
    private func setAccessibilityIdentifier() {
        self.view.accessibilityIdentifier = PetModuleAccessibilityIdentifier.petDetail
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
    }
    
    private func setPetDetailView() {
        self.title = viewModel.title
        self.petName.text = viewModel.petDetail.petName
        self.petBreedGroup.text = viewModel.petDetail.petBreedGroup
        self.petBreedFor.text = viewModel.petDetail.petBreed
        self.petTemperment.text = viewModel.petDetail.petTemperament
        self.PetOrigin.text = viewModel.petDetail.petOrigin
        self.petLifeSpan.text = viewModel.petDetail.petLifeSpan
    }
}
