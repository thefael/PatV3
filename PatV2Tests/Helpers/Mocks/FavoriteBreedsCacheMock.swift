@testable import PatV2
import UIKit

class FavoriteBreedsCacheMock: FavoriteBreedsCacheType {
    var cache: [String]
    var defaults: UserDefaultsAdaptable

    var didCallPut = false
    var didCallRemove = false

    init(cache: [String] = [String](), defaults: UserDefaultsAdaptable = UserDefaultsAdapterMock()) {
        self.cache = cache
        self.defaults = defaults
    }

    func put(breed: String) {
        didCallPut = true
    }

    func remove(breed: String) {
        didCallRemove = true
    }


}
