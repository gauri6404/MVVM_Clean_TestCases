import UIKit

class PetListViewController: UIViewController, AlertUtility, Storyboardable {

    @IBOutlet weak var petListTableView: PetListTableView!
    
    var viewModel: PetListViewModel!
    var router: PetListRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.getPetList()
        petListTableView.isHidden = false
    }
    
    private func setupViews() {
        title = viewModel.screenTitle
        petListTableView.viewModel = viewModel
    }
    
    private func bind(to viewModel: PetListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading(loading: $0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func updateItems() {
        petListTableView.reload()
    }
    
    private func updateLoading(loading: Bool) {
        LoaderUtility.shared.hideOverlayView()
        if loading {
            LoaderUtility.shared.showOverlay(view: self.petListTableView)
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Error", message: error)
    }
}

extension PetListViewController: PetListAction {
    func action_showPetdetail(for model: PetInfoPresentationModel) {
        router?.action_showPetdetail(for: model)
    }
}
