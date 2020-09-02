
import Foundation

protocol CoffeeMaker {
    func prepare(_ beans: Bean)
    func make()
}

protocol CoffeeEssentials {
    var coffeeMaker: CoffeeMaker { get }
    var bean: Bean { get }
}

final class CoffeeApp {
    
    private let essentials: CoffeeEssentials
    
    // MARK: - Init
    
    init(_ essentials: CoffeeEssentials) {
        self.essentials = essentials
    }

    // MARK: - Public API

    func makeCoffeeForMe() {
        essentials.coffeeMaker.prepare(essentials.bean)
        essentials.coffeeMaker.make()
    }
}

class FilterCoffeeMaker: CoffeeMaker {
    
    private let cafetiere = Cafetiere()
    
    // MARK: - CoffeeMaker
    
    func prepare(_ beans: Bean) {
        cafetiere.groundCoffee = beans.grind()
    }
    
    func make() {
        cafetiere.plunge()
    }
    
    // MARK: - Helpers
    
    private func fill(with groundCoffee: GroundCoffee) {
        cafetiere.groundCoffee = groundCoffee
    }

    private func brew() {
        cafetiere.plunge()
    }

}

class BeanToCupMachine: CoffeeMaker {
    
    private var beans: Bean?

    // MARK: - CoffeeMaker
    
    func make() {
        guard let groundCoffee = beans?.grind() else {
            return
        }
        _ = groundCoffee
        // make the coffee from the grounds
    }
        
    func prepare(_ beans: Bean) {
        add(beans)
    }
    
    // MARK: - Helpers

    private func add(_ beans: Bean) {
        self.beans = beans
    }

}

class EspressoMachine: CoffeeMaker {
    
    private var beans: Bean?
    
    func prepare(_ beans: Bean) {
        self.beans = beans
    }
    
    func make() {
        guard let groundCoffee = beans?.grind() else { return }
        make(from: groundCoffee)
    }
    
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
