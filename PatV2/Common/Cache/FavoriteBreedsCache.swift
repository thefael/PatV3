import UIKit

protocol FavoriteBreedsCacheType {
    var cache: [String] { get set }
    var defaults: UserDefaultsAdaptable { get set }
    func set(breed: String, forKey key: String)
    func remove(breed: String)
}

class FavoriteBreedsCache: FavoriteBreedsCacheType {
    var cache: [String]
    var defaults: UserDefaultsAdaptable

    init(cache: [String], defaults: UserDefaultsAdapter) {
        if let cache = defaults.getObject(forKey: Constants.favoriteCacheKey) as? [String] {
            self.cache = cache
        } else { self.cache = cache }
        self.defaults = defaults
    }

    func set(breed: String, forKey key: String) {
        cache.append(breed)
        defaults.set(cache, forKey: Constants.favoriteCacheKey)
    }

    func remove(breed: String) {
        cache.removeAll { $0 == breed }
        defaults.set(cache, forKey: Constants.favoriteCacheKey)
    }
}
