import UIKit

struct MoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [MovieDTO]
}

struct MovieDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case genre
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    enum GenreDTO: String, Decodable {
        case adventure
        case scienceFiction = "science_fiction"
    }
    let id: Int
    let title: String?
    let genre: GenreDTO?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
}

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

