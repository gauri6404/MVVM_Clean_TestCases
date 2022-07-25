import Foundation

enum LoadingType {
    case fullScreen
    case nextPage
}

protocol PetListViewModelInput {
    func getPetList()
}

protocol PetListViewModelOutput {
    
    var items: Observable<[PetListItemViewModel]> { get }
    var loading: Observable<LoadingType?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
}

protocol PetListViewModel: PetListViewModelInput, PetListViewModelOutput {
    var petListLimit: Int { get }
}

final class PetListViewModelImplementation: PetListViewModel {

    private let petListUseCase: PetListUseCase
    private var petList: [PetListResponseModel] = []
    
    var petListLimit: Int = 10

    var items: Observable<[PetListItemViewModel]> = Observable([])
    var loading: Observable<LoadingType?> = Observable(.none)
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var screenTitle: String = "Pet List"

    init(petListUseCase: PetListUseCase) {
        self.petListUseCase = petListUseCase
    }

    private func appendPet(list: [PetListResponseModel]) {
        petList.append(contentsOf: list)
        items.value = petList.map(PetListItemViewModel.init)
        if items.value.isEmpty {
            self.handle(error: NetworkError.noDataError)
        }
    }

    private func resetPages() {
        petList.removeAll()
        items.value.removeAll()
    }

    private func load(loading: LoadingType) {
        self.loading.value = loading
        petListUseCase.execute(requestValue: PetListUseCaseRequestValue(limit: petListLimit), completion: { result in
            switch result {
            case .success(let model):
                self.appendPet(list: model ?? [])
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = .none
        })
    }

    private func handle(error: Error) {
        self.error.value = (error as! NetworkError) == NetworkError.notConnected ? "No Internet Connection" : "Failed loading pet list"
    }

    private func update() {
        resetPages()
        load(loading: .fullScreen)
    }
    
    func getPetList() {
        resetPages()
        load(loading: .fullScreen)
    }
}
