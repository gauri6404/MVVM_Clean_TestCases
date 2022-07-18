//import Foundation
//
//final class AppDIContainer {
//        
//    // MARK: - Network
//    lazy var networkManager: NetworkManager = {
//        
//        let apiConfig = APIRequestConfigImplementation(url: "", methodType: .get, headers: [:], queryParameters: [:], bodyParameters: [:], bodyEncoding: .jsonSerializationData)
//        NetworkManagerImplementation(service: NetworkServiceImplementation(apiConfig: apiConfig))
//        
//        
//        let config = ApiRequestNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
//                                          queryParameters: ["api_key": appConfiguration.apiKey,
//                                                            "language": NSLocale.preferredLanguages.first ?? "en"])
//        let apiDataNetwork = DefaultNetworkService(config: config)
//        return DefaultDataTransferService(with: apiDataNetwork)
//    }()
//    lazy var imageDataTransferService: DataTransferService = {
//        let config = ApiRequestNetworkConfig(baseURL: URL(string: appConfiguration.imagesBaseURL)!)
//        let imagesDataNetwork = DefaultNetworkService(config: config)
//        return DefaultDataTransferService(with: imagesDataNetwork)
//    }()
//    
//    // MARK: - DIContainers of scenes
//    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
//        let dependencies = MoviesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService,
//                                                               imageDataTransferService: imageDataTransferService)
//        return MoviesSceneDIContainer(dependencies: dependencies)
//    }
//}
