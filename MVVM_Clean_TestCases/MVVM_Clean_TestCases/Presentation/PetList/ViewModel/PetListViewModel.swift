import Foundation

enum LoadingType {
    case fullScreen
    case nextPage
}

protocol PetListViewModelInput {
    func didLoadNextPage()
    func getPetList()
    func viewDidLoad()
}

protocol PetListViewModelOutput {
    var items: Observable<[PetListItemViewModel]> { get }
    var loading: Observable<LoadingType?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
}

protocol PetListViewModel: PetListViewModelInput, PetListViewModelOutput {}

final class PetListViewModelImplementation: PetListViewModel {

    private let petListUseCase: PetListUseCase

    var currentPage: Int = 0
    var totalPetCount: Int = 264
    var hasMorePages: Bool { items.value.count < totalPetCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    private var pages: [PetPage] = []

    // MARK: - OUTPUT

    var items: Observable<[PetListItemViewModel]> = Observable([])
    var loading: Observable<LoadingType?> = Observable(.none)
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var screenTitle: String = "Pet List"

    // MARK: - Init

    init(petListUseCase: PetListUseCase) {
        self.petListUseCase = petListUseCase
    }

    // MARK: - Private

    private func appendPage(petPage: PetPage) {
        currentPage = nextPage
        pages = pages + [petPage]
        items.value = petPage.petList.map(PetListItemViewModel.init)
        if items.value.isEmpty {
            self.handle(error: NetworkError.noDataError)
        }
    }

    private func resetPages() {
        currentPage = 0
        totalPetCount = 264
        pages.removeAll()
        items.value.removeAll()
    }

    private func load(loading: LoadingType) {
        self.loading.value = loading
        petListUseCase.execute(requestValue: PetListUseCaseRequestValue(currentPageIndex: self.currentPage, limit: 10), completion: { result in
            switch result {
            case .success(let model):
                let petPage = PetPage(page: self.currentPage, totalPetCount: 264, petList: model ?? [])
                self.appendPage(petPage: petPage)
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = .none
        })
    }

    private func handle(error: Error) {
//        self.error.value = error.isInternetConnectionError ?
//            NSLocalizedString("No internet connection", comment: "") :
//            NSLocalizedString("Failed loading movies", comment: "")
        self.error.value = "Failed loading pet details"
    }

    private func update() {
        resetPages()
        load(loading: .fullScreen)
    }
    
    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(loading: .nextPage)
    }
    
    func getPetList() {
        resetPages()
        load(loading: .fullScreen)
    }
    
    func viewDidLoad() {
    }
}
