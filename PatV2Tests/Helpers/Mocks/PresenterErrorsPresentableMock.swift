@testable import PatV2
import UIKit

class PresenterErrorsPresentableMock: PresenterErrorsPresetable {
    var didCallDisplayErrorMessage = false

    func displayErrorMessage(error: Error) {
        didCallDisplayErrorMessage = true
    }
}
