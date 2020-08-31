
import Foundation

protocol Loader {
    func loadAnimals(_ callback: @escaping (Result<Any, Error>) -> Void)
}

class UserDefaultsLoader: Loader {
    func loadAnimals(_ callback: @escaping (Result<Any, Error>) -> Void) {
        if let savedAnimals = UserDefaults.standard.stringArray(forKey: "animals") {
            callback(.success(savedAnimals))
        } else {
            callback(.failure(NoAnimalsError()))
        }
    }
}

class NetworkLoader: Loader {
    func loadAnimals(_ callback: @escaping (Result<Any, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: "https://www.animalsgalore.com/api")!) { maybeData, _, maybeError in
            if let _ = maybeError {
                preconditionFailure("Error occurred when downloading data")
            } else if let data = maybeData {
                let animals = try! JSONDecoder().decode([String: String].self, from: data)
                callback(.success(animals))
            } else {
                preconditionFailure("No animals")
            }
        }
        task.resume()
    }
}

struct NoAnimalsError: Error {}

struct UnknownError: Error {}
