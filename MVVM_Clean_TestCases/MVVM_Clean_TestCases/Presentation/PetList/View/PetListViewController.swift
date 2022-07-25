import UIKit

class PetListViewController: UIViewController, AlertUtility {

    @IBOutlet weak var petListTableView: PetListTableView!
    
    var viewModel: PetListViewModel!

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
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func updateItems() {
        petListTableView.reload()
    }
    
    private func updateLoading(_ loading: LoadingType?) {
//        petListTableView.isHidden = true
        LoaderUtility.shared.hideOverlayView()

        switch loading {
        case .fullScreen:
            LoaderUtility.shared.showOverlay(view: self.view)
        case .nextPage:
//            petListTableView.isHidden = false
            LoaderUtility.shared.showOverlay(view: self.view)
        case .none:
            break
//            petListTableView.isHidden = viewModel.isEmpty
        }
        petListTableView.updateLoading(loading)
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Error", message: error)
    }
}
