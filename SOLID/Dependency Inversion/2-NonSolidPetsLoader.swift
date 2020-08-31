
import UIKit

class NonSolidCutePetsLoader {
    func showPets(on view: UILabel) {
        URLSession.shared.dataTask(with: petsApi) { data, _, _ in
            if let data = data {
                do {
                    view.text = try JSONDecoder().decode([String].self, from: data).joined(separator: ", ")
                } catch {
                    view.text = "Oh no! An error"
                }
            } else {
                view.text = "Oh no! An error"
            }
        }.resume()
    }
}
