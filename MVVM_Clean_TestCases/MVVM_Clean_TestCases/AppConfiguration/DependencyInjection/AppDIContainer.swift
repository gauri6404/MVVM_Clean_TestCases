import Foundation

final class AppDIContainer {
        
    // MARK: - Network
    lazy var networkManager: NetworkManager = {
        
        let apiBaseConfig = NetworkBaseConfigurationImpl(baseURL: PListUtility.getValue(forKey: "API_BASE_URL") as! String, headers: ["Content-Type": "application/json", "x-api-key": "267adccb-d489-46cf-86a3-f9a42a2dfb90"])
        return NetworkManagerImplementation(service: NetworkServiceImplementation(apiConfig: apiBaseConfig))
    }()
    
    lazy var imageNetworkManager: NetworkManager = {
        let apiBaseConfig = NetworkBaseConfigurationImpl(baseURL: "")
        return NetworkManagerImplementation(service: NetworkServiceImplementation(apiConfig: apiBaseConfig))
    }()
    
    // MARK: - DIContainers of scenes
    func getPetModuleDIContainer() -> PetModuleDIContainer {
        let dependencies = PetModuleDIContainer.Dependencies(networkManager: networkManager, imageNetworkManager: imageNetworkManager)
        return PetModuleDIContainer(dependencies: dependencies)
    }
}
