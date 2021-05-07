import UIKit

class FavoriteButtonService {
    private let favoritesCache: FavoriteBreedsCacheType

    init(cache: FavoriteBreedsCacheType = FavoriteBreedsCache.shared) {
        self.favoritesCache = cache
    }

    func getInitialButtonImage(for breed: String) -> UIImage? {
        return isFavorite(breed: breed) ? .heartFill : .heart
    }

    private func isFavorite(breed: String) -> Bool {
        if favoritesCache.cache.contains(breed) {
            return true
        } else {
            return false
        }
    }

    func toggleFavorite(breed: String) -> FavoriteState {
        if favoritesCache.cache.contains(breed) {
            favoritesCache.remove(breed: breed)
            return .isNotFavorite
        } else {
            favoritesCache.put(breed: breed)
            return .isFavorite
        }
    }
}
