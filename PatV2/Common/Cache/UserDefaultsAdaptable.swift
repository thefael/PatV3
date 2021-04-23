import UIKit

protocol UserDefaultsAdaptable {
    var defaults: UserDefaults { get set }
    func set(_ object: Any, forKey key: String)
    func getObject(forKey key: String) -> Any?
    func removeObject(forKey key: String)
}

class UserDefaultsAdapter: UserDefaultsAdaptable {
    var defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func set(_ object: Any, forKey key: String) {
        defaults.setValue(object, forKey: key)
    }

    func getObject(forKey key: String) -> Any? {
        return defaults.object(forKey: key)
    }

    func removeObject(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
