
import Foundation

protocol Loader {
    func loadAnimals(_ callback: @escaping (Result<[String], Error>) -> Void)
}

class UserDefaultsLoader: Loader {
    func loadAnimals(_ callback: @escaping (Result<[String], Error>) -> Void) {
        if let savedAnimals = UserDefaults.standard.stringArray(forKey: "animals") {
            callback(.success(savedAnimals))
        } else {
            callback(.failure(NoAnimalsError()))
        }
    }
}

class NetworkLoader: Loader {
    func loadAnimals(_ callback: @escaping (Result<[String], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: "https://www.animalsgalore.com/api")!) { maybeData, _, maybeError in
            if let customError = maybeError {
                callback(.failure(customError))
            } else if let data = maybeData {
                let animals = try! JSONDecoder().decode([String: String].self, from: data)
                
                callback(.success(animals.map{$0.value}))
            } else {
                callback(.failure(NoAnimalsError()))
            }
        }
        task.resume()
    }
}

struct NoAnimalsError: Error {}
