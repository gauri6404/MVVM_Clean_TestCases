import Foundation

protocol PetListViewModelInput {
    func getPetList()
}

protocol PetListViewModelOutput {
    
    var items: Observable<[PetListItemViewModel]> { get }
    var loading: Observable<Bool> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
}

protocol PetListViewModel: PetListViewModelInput, PetListViewModelOutput {
}

final class PetListViewModelImplementation: PetListViewModel {

    private let petListUseCase: PetListUseCase
    private var petList: [PetInfoModel] = []
    var items: Observable<[PetListItemViewModel]> = Observable([])
    var loading: Observable<Bool> = Observable(false)
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var screenTitle: String = "Pet List"

    init(petListUseCase: PetListUseCase) {
        self.petListUseCase = petListUseCase
    }

    private func appendPet(list: [PetInfoModel]) {
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

    private func load() {
        self.loading.value = true
        petListUseCase.execute(completion: { result in
            switch result {
            case .success(let model):
                self.appendPet(list: model ?? [])
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = false
        })
    }

    private func handle(error: Error) {
        self.error.value = (error as! NetworkError) == NetworkError.notConnected ? "No Internet Connection" : "Failed loading pet list"
    }
    
    func getPetList() {
        resetPages()
        load()
    }
}
