import UIKit

class FavoriteButtonPresenter {
    private let favoritesCache = FavoriteBreedsCache.shared

    private let heart = UIImage(systemName: "heart")
    private let heartFill = UIImage(systemName: "heart.fill")

    func getInitialButtonImage(for breed: String) -> UIImage? {
        return isFavorite(breed: breed) ? heartFill : heart
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
