@testable import PatV2
import XCTest

class FavoriteBreedsCacheTests: XCTestCase {
    var testCache = [String]()
    let testBreed = BreedsFixture.breedList[0]
    let defaults = UserDefaultsAdapterMock()
    lazy var favoriteBreedsCache = FavoriteBreedsCache(cache: testCache, defaults: defaults)

    func test_put_shouldCallSet() {
        favoriteBreedsCache.put(breed: testBreed)

        XCTAssert(defaults.didCallSet)
    }

    func test_put_shouldSetBreedIntoCache() {
        favoriteBreedsCache.put(breed: testBreed)

        let cache = favoriteBreedsCache.cache

        XCTAssert(cache.contains(testBreed))
    }

    func test_remove_shouldCallSet() {
        favoriteBreedsCache.remove(breed: testBreed)

        XCTAssert(defaults.didCallSet)
    }

    func test_remove_shouldRemoveBreedFromCache() {
        testCache.append(testBreed)
        favoriteBreedsCache.cache = testCache

        favoriteBreedsCache.remove(breed: testBreed)

        let cache = favoriteBreedsCache.cache
        XCTAssertFalse(cache.contains(testBreed))
    }
}
