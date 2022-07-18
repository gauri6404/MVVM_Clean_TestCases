import UIKit

class PetListTableView: UITableView {
        
    var viewModel: PetListViewModel!
    var petImagesRepository: PetImageRepository?
    
    var posterImagesRepository: PetListRepository?
    var nextPageLoadingSpinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life cycle methods
    override func awakeFromNib() {
        self.setupViews()
        self.setupCell()
        self.setUpDataSourceAndDelegate()
    }
    
    func reload() {
        self.reloadData()
    }
    
    private func setupViews() {
        self.accessibilityIdentifier = AccessibilityIdentifier.tableView
        self.separatorStyle = .none
    }
    
    private func setupCell() {
        self.register(UINib(nibName: String(describing: PetInfoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PetInfoTableViewCell.self))
    }
    
    private func setUpDataSourceAndDelegate() {
        self.delegate = self
        self.dataSource = self
    }
    
    func updateLoading(_ loading: LoadingType?) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner.removeFromSuperview()
            nextPageLoadingSpinner = UIActivityIndicatorView(style: .medium)
            self.tableFooterView = nextPageLoadingSpinner
        case .fullScreen, .none:
            self.tableFooterView = nil
        }
    }
}

extension PetListTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PetInfoTableViewCell.self), for: indexPath) as? PetInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.show(with: viewModel.items.value[indexPath.row], petImagesRepository: petImagesRepository)
//        if indexPath.row == viewModel.items.value.count - 1 {
//            viewModel.didLoadNextPage()
//        }
        return cell
    }
}
