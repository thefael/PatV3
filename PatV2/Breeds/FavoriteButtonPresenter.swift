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

    func tapButton(_ button: UIButton, for breed: String) {
        if isFavorite(breed: breed) {
            favoritesCache.remove(breed: breed)
            button.setImage(heart, for: .normal)
        } else {
            favoritesCache.put(breed: breed)
            button.setImage(heartFill, for: .normal)
        }
    }
}
