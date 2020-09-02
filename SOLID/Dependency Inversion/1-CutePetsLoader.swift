
import Foundation

let petsApi = URL(string: "api.awesomepetpics.com/v1/best-pets")!

protocol Network {
    func load(from url: URL, callback: @escaping ((Result<[String], Error>) -> Void))
}

class CutePetsLoader {
    // Implemented in P1E05
    private let network: Network

    init(dependency: Network){
        self.network = dependency
    }
}

class URLSessionNetwork: Network {
    let session: URLSession
    
    init(_ session: URLSession = .shared){
        self.session = session
    }
    
    private enum Error: Swift.Error {
        case noData
        case jsonDecodeError
    }
    
    // MARK: - Network conformance
    
    func load(from url: URL,callback: @escaping ((Result<[String], Swift.Error>) -> Void)) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                callback(.failure(error))
                return
            }
            guard let data = data, !data.isEmpty else {
                callback(.failure(Error.noData))
                return
            }
            
            
            do {
                let pets = try JSONDecoder().decode([String].self, from: data)
                callback(.success(pets))
            } catch {
                callback(.failure(error))
            }
        }
    }
}
