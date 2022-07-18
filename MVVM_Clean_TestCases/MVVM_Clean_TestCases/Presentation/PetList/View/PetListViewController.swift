import UIKit

class PetListViewController: UIViewController, AlertUtility {

    @IBOutlet weak var petListTableView: PetListTableView!
    
    private var viewModel: PetListViewModel!
    private var petImagesRepository: PetImageRepository?
    
    static func create(with viewModel: PetListViewModel, petImagesRepository: PetImageRepository?) -> PetListViewController {
        let view = UIStoryboard(name: "PetListStoryboard", bundle: nil).instantiateViewController(withIdentifier: String(describing: PetListViewController.self)) as! PetListViewController
        view.viewModel = viewModel
        view.petImagesRepository = petImagesRepository
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        viewModel.getPetList()
    }
    
    private func setupViews() {
        title = viewModel.screenTitle
        petListTableView.viewModel = viewModel
        petListTableView.petImagesRepository = petImagesRepository
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
        petListTableView.isHidden = true
        LoaderUtility.shared.hideOverlayView()

        switch loading {
        case .fullScreen:
            LoaderUtility.shared.showOverlay(view: self.view)
        case .nextPage:
            petListTableView.isHidden = false
            LoaderUtility.shared.showOverlay(view: self.view)
        case .none: petListTableView.isHidden = viewModel.isEmpty
        }
        petListTableView.updateLoading(loading)
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(message: error)
    }
}
