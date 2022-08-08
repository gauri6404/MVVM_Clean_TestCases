import Foundation

protocol PetListAction: AnyObject {
    func action_showPetdetail(for model: PetInfoPresentationModel)
}

protocol PetListViewModelInput: AnyObject {
    func getPetList()
    func showPetDetail(for index: Int)
}

protocol PetListViewModelOutput: AnyObject {
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
    private var petList: [PetInfoPresentationModel] = []
    private weak var actionDelegate: PetListAction?
    
    var items: Observable<[PetListItemViewModel]> = Observable([])
    var loading: Observable<Bool> = Observable(false)
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var screenTitle: String = "Pet List"

    init(petListUseCase: PetListUseCase, actionDelegate: PetListAction? = nil) {
        self.petListUseCase = petListUseCase
        self.actionDelegate = actionDelegate
    }

    private func appendPet(list: [PetInfoPresentationModel]) {
        petList.append(contentsOf: list)
        items.value = petList.map(PetListItemViewModel.init)
        if items.value.isEmpty {
            self.handle(error: NetworkError.noDataError)
        }
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
        load()
    }
    
    func showPetDetail(for index: Int) {
        self.actionDelegate?.action_showPetdetail(for: petList[index])
    }
}
