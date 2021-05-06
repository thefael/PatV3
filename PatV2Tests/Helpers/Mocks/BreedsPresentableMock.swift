@testable import PatV2
import UIKit

class BreedsPresentableMock: BreedsPresentable {
    var breedsPassed: [Breed]?

    func passBreeds(breeds: [Breed]) {
        breedsPassed = breeds
    }
}
