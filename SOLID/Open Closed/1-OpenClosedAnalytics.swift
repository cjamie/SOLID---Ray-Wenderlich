
import Foundation

enum AnalyticsEvent {
    case userPickedAnimal(_ animal: String)
    case addedNewAnimal(_ animal: String)
    case removedNewAnimal(_ animal: String)
    case appCrashed(_ error: Error)

    var name: String {
        switch self {
        case .userPickedAnimal:
            return "user_picked_animal"
        case .addedNewAnimal:
            return "added_new_animal"
        case .removedNewAnimal:
            return "removed_animal"
        case .appCrashed:
            return "app_crashed"
        }
    }

    var label: String {
        switch self {
        case .userPickedAnimal:
            return "user_interaction"
        case .addedNewAnimal:
            return "user_interaction"
        case .removedNewAnimal:
            return "user_interaction"
        case .appCrashed:
            return "error"
        }
    }

    var additionalProperties: [String: String] {
        switch self {
        case let .userPickedAnimal(animal):
            return ["animal": animal]
        case let .addedNewAnimal(animal):
            return ["animal": animal]
        case let .removedNewAnimal(animal):
            return ["animal": animal]
        case let .appCrashed(cause):
            return ["cause": cause.localizedDescription]
        }
    }
}
