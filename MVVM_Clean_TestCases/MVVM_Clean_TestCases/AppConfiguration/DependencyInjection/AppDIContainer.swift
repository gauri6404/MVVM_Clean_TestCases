import Foundation

final class AppDIContainer {
        
    // MARK: - Network
    lazy var networkManager: NetworkManager = {
        
        let apiBaseConfig = NetworkBaseConfigurationImpl(baseURL: PListUtility.getValue(forKey: "API_BASE_URL") as! String, headers: ["Content-Type": "application/json", "x-api-key": PListUtility.getValue(forKey: "API_KEY") as! String])
        return NetworkManagerImplementation(service: NetworkServiceImplementation(apiConfig: apiBaseConfig))
    }()
    
    // MARK: - DIContainers of scenes
    func getPetListDIContainer() -> PetListDIContainer {
        let dependencies = PetListDIContainer.Dependencies(networkManager: networkManager)
        return PetListDIContainer(dependencies: dependencies)
    }
}
