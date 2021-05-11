@testable import PatV2
import UIKit

class DogsPresentableMock: DogsPresentable {
    var didCallPassData = false
    var didCallPass = false

    func passData(urls: [URL]) {
        didCallPassData = true
    }

    func pass(image: UIImage, to cell: DogCell) {
        didCallPass = true
    }
}
