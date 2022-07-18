import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiConfig  = APIRequestConfigImplementation(url: "3/search/movie/", methodType: .get, headers: [:], queryParameters: ["page": "1", "query":"A", "api_key": "2696829a81b1b5827d515ff121700838", "language": "en"], bodyParameters: [:], bodyEncoding: .jsonSerializationData)
//        let apiConfig  = APIRequestConfigImplementation(url: "https://api.themoviedb.org/3/search/movie/", methodType: .get, headers: [:], queryParameters: ["page": "1", "query":"A"], bodyParameters: [:], bodyEncoding: .jsonSerializationData)
        NetworkManagerImplementation(service: NetworkServiceImplementation(apiConfig: apiConfig, sessionManager: NetworkSessionManagerImplementation(), logger: NetworkLoggerImplementation())).getAPIResponse(for: apiConfig, returnType: MoviesResponseDTO.self) { result in
            print(result)
        }
    }
}

