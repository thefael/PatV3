@testable import PatV2
import UIKit

class UserDefaultsAdapterMock: UserDefaultsAdaptable {
    var didCallSet = false
    var didCallGetObject = false

    func set(_ object: Any, forKey key: String) {
        didCallSet = true
    }

    func getObject(forKey key: String) -> Any? {
        didCallGetObject = true
        return nil
    }
}
