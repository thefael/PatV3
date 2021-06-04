@testable import PatV2
import XCTest

class FavoriteButtonServiceTests: XCTestCase {
    let breedFixture = BreedsFixture.breedList[0]
    lazy var cacheWithBreed = FavoriteBreedsCacheMock(cache: [breedFixture])
    let cacheWithNoBreed = FavoriteBreedsCacheMock()

    func test_getInitialButtonImage_whenBreedIsFavorite_shouldReturnCorrectImage() {
        let service = FavoriteButtonService(cache: cacheWithBreed)

        let image = service.getInitialButtonImage(for: breedFixture)

        XCTAssertEqual(image, UIImage.heartFill)
    }

    func test_getInitialButtonImage_whenBreedIsNotFavorite_shouldReturnCorrectImage() {
        let service = FavoriteButtonService(cache: cacheWithNoBreed)

        let image = service.getInitialButtonImage(for: breedFixture)

        XCTAssertEqual(image, UIImage.heart)
    }

    func test_toggleFavorite_whenBreedIsFavorite_shouldCallRemove() {
        let service = FavoriteButtonService(cache: cacheWithBreed)

        let _ = service.toggleFavorite(breed: breedFixture)

        XCTAssert(cacheWithBreed.didCallRemove)
    }

    func test_toggleFavorite_whenBreedIsFavorite_shouldReturnNewFavoriteState_isNotFavorite() {
        let service = FavoriteButtonService(cache: cacheWithBreed)

        let favoriteState = service.toggleFavorite(breed: breedFixture)

        XCTAssertEqual(favoriteState, FavoriteState.isNotFavorite)
    }

    func test_toggleFavorite_whenBreedIsNotFavorite_shouldCallPut() {
        let service = FavoriteButtonService(cache: cacheWithNoBreed)

        let _ = service.toggleFavorite(breed: breedFixture)

        XCTAssert(cacheWithNoBreed.didCallPut)
    }

    func test_toggleFavorite_whenBreedIsNotFavorite_shouldReturnNewFavoriteState_isFavorite() {
        let service = FavoriteButtonService(cache: cacheWithNoBreed)

        let favoriteState = service.toggleFavorite(breed: breedFixture)

        XCTAssertEqual(favoriteState, FavoriteState.isFavorite)
    }
}
