@testable import PatV2
import XCTest

class FavoriteButtonServiceTests: XCTestCase {
    let breedFixture = BreedsFixture.breedList[0]
    let favoriteCache = FavoriteBreedsCacheMock()

    func test_getInitialButtonImage_whenBreedIsFavorite_shouldReturnCorrectImage() {
        let service = FavoriteButtonService(cache: favoriteCache)
        breedIsFavorite(true)

        let image = service.getInitialButtonImage(for: breedFixture)

        XCTAssertEqual(image, UIImage.heartFill)
    }

    func test_getInitialButtonImage_whenBreedIsNotFavorite_shouldReturnCorrectImage() {
        let service = FavoriteButtonService(cache: favoriteCache)
        breedIsFavorite(false)

        let image = service.getInitialButtonImage(for: breedFixture)

        XCTAssertEqual(image, UIImage.heart)
    }

    func test_toggleFavorite_whenBreedIsFavorite_shouldCallRemove() {
        let service = FavoriteButtonService(cache: favoriteCache)
        breedIsFavorite(true)

        let _ = service.toggleFavorite(breed: breedFixture)

        XCTAssert(favoriteCache.didCallRemove)
    }

    func test_toggleFavorite_whenBreedIsFavorite_shouldReturnNewFavoriteState_isNotFavorite() {
        let service = FavoriteButtonService(cache: favoriteCache)
        breedIsFavorite(true)

        let favoriteState = service.toggleFavorite(breed: breedFixture)

        XCTAssertEqual(favoriteState, FavoriteState.isNotFavorite)
    }

    func test_toggleFavorite_whenBreedIsNotFavorite_shouldCallPut() {
        let service = FavoriteButtonService(cache: favoriteCache)
        breedIsFavorite(false)

        let _ = service.toggleFavorite(breed: breedFixture)

        XCTAssert(favoriteCache.didCallPut)
    }

    func test_toggleFavorite_whenBreedIsNotFavorite_shouldReturnNewFavoriteState_isFavorite() {
        let service = FavoriteButtonService(cache: favoriteCache)
        breedIsFavorite(false)

        let favoriteState = service.toggleFavorite(breed: breedFixture)

        XCTAssertEqual(favoriteState, FavoriteState.isFavorite)
    }

    func breedIsFavorite(_ isFavorite: Bool) {
        favoriteCache.isFavoriteHandler = { _ in isFavorite }
    }
}
