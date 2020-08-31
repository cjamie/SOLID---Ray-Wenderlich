
import Foundation

class CoffeeApp {
    func makeCoffeeForMe() {
        let coffeeMaker = FilterCoffeeMaker()
        coffeeMaker.fill(with: Bean.arabica.grind())
        coffeeMaker.brew()
    }
}

class FilterCoffeeMaker {
    private let cafetiere = Cafetiere()

    func fill(with groundCoffee: GroundCoffee) {
        cafetiere.groundCoffee = groundCoffee
    }

    func brew() {
        cafetiere.plunge()
    }
}

class BeanToCupMachine {
    private var beans: Bean?

    func add(_ beans: Bean) {
        self.beans = beans
    }

    func make() {
        guard let groundCoffee = beans?.grind() else {
            return
        }
        _ = groundCoffee
        // make the coffee from the grounds
    }
}

class EspressoMachine {
    func make(from _: GroundCoffee) {
        // yum, our coffee is nearly ready
    }
}

struct Bean {
    let strength: Int

    static let arabica = Bean(strength: 3)
    static let robusta = Bean(strength: 4)

    func grind() -> GroundCoffee {
        GroundCoffee(strength: strength)
    }
}

class Cafetiere {
    var groundCoffee: GroundCoffee?

    func plunge() {
        // push the plunger down!
    }
}

struct GroundCoffee {
    let strength: Int
}
