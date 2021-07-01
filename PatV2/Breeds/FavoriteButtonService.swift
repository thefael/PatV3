import UIKit

protocol FavoriteButtonServiceType {
    func getInitialButtonImage(for breed: String) -> UIImage?
    func toggleFavorite(breed: String) -> FavoriteState
}

class FavoriteButtonService: FavoriteButtonServiceType {
    private let favoritesCache: FavoriteBreedsCacheType

    init(cache: FavoriteBreedsCacheType = FavoriteBreedsCache.shared) {
        self.favoritesCache = cache
    }

    func getInitialButtonImage(for breed: String) -> UIImage? {
        return favoritesCache.isFavorite(breed: breed) ? .heartFill : .heart
    }

    func toggleFavorite(breed: String) -> FavoriteState {
        if favoritesCache.isFavorite(breed: breed) {
            favoritesCache.remove(breed: breed)
            return .isNotFavorite
        } else {
            favoritesCache.put(breed: breed)
            return .isFavorite
        }
    }
}
