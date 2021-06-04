@testable import PatV2
import UIKit

class BreedsPresentableMock: BreedsPresentable {
    var breedsPassed: [Breed]?
    var errorPresented: TestError?

    func passBreeds(breeds: [Breed]) {
        breedsPassed = breeds
    }

    func presentError(error: Error) {
        errorPresented = error as? TestError
    }
}
