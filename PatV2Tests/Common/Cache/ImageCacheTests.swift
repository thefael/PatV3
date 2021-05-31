@testable import PatV2
import XCTest

class ImageCacheTests: XCTestCase {
    let cache = NSCache<NSURL, UIImage>()
    let testImage = ImageCacheSavable.testImage
    let testNSURL = ImageCacheSavable.testNSURL
    lazy var imageCache = ImageCache(cache: cache)

    func test_set_shouldSetObject_intoNSCache() {
        imageCache.set(image: testImage, forKey: testNSURL)

        let savedImage = cache.object(forKey: testNSURL)

        XCTAssertEqual(savedImage, testImage)
    }

    func test_getImage_shouldReturnCorrectImageForKey() {
        cache.setObject(testImage, forKey: testNSURL)

        let image = imageCache.getImage(forKey: testNSURL)

        XCTAssertEqual(image, testImage)
    }
}
