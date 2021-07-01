import UIKit

protocol FavoriteBreedsCacheType {
    func put(breed: String)
    func remove(breed: String)
    func getFavorites() -> [String]
    func isFavorite(breed: String) -> Bool
}

class FavoriteBreedsCache: FavoriteBreedsCacheType {
    private var cache: [String]
    static let shared = FavoriteBreedsCache()
    private var defaults: UserDefaultsAdaptable

    init(cache: [String] = [String](), defaults: UserDefaultsAdaptable = UserDefaultsAdapter()) {
        if let cache = defaults.getObject(forKey: Constants.favoriteCacheKey) as? [String] {
            self.cache = cache
        } else { self.cache = cache }
        self.defaults = defaults
    }

    func put(breed: String) {
        cache.append(breed)
        defaults.set(cache, forKey: Constants.favoriteCacheKey)
    }

    func remove(breed: String) {
        cache.removeAll { $0 == breed }
        defaults.set(cache, forKey: Constants.favoriteCacheKey)
    }

    func getFavorites() -> [String] {
        return cache
    }

    func isFavorite(breed: String) -> Bool {
        cache.contains(breed)
    }
}
