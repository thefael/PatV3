@testable import PatV2
import UIKit

class FavoriteBreedsCacheMock: FavoriteBreedsCacheType {
    var cache: [String]
    var defaults: UserDefaultsAdaptable

    var didCallPut = false
    var didCallRemove = false
    var didCallGetFavorites = false
    var didCallIsFavorites = false
    var isFavoriteHandler: ((String) -> Bool)?
    var getFavoritesHandler: (() -> [String])?

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

    func getFavorites() -> [String] {
        getFavoritesHandler!()
    }

    func isFavorite(breed: String) -> Bool {
        return isFavoriteHandler!(breed)
    }
}
