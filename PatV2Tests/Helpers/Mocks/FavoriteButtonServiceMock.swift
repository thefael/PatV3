@testable import PatV2
import UIKit

class FavoriteButtonServiceMock: FavoriteButtonServiceType {
    var didCallGetiInitialButtonImage = false
    var didCallToggleFavorite = false

    func getInitialButtonImage(for breed: String) -> UIImage? {
        didCallGetiInitialButtonImage = true
        return nil
    }

    func toggleFavorite(breed: String) -> FavoriteState {
        didCallToggleFavorite = true
        return .isFavorite
    }


}
