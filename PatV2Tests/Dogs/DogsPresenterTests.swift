@testable import PatV2
import XCTest

class DogsPresenterTests: XCTestCase {
    let serviceMock = ServiceMock<[URL]>()
    let cacheMock = ImageCacheMock()
    let presentableMock = DogsPresentableMock()
    let errorPresentableMock = PresenterErrorsPresentableMock()

    lazy var dogsPresenter = DogsPresenter(service: serviceMock, cache: cacheMock)
    let url = ImageCacheSavable.testNSURL as URL
    let dogCell = DogCell()
    let testImage = ImageCacheSavable.testImage
    let testNSURL = ImageCacheSavable.testNSURL

    override func setUp() {
        dogsPresenter.presentable = presentableMock
        dogsPresenter.errorPresentable = errorPresentableMock
    }

    func test_fetchURLs_whenResultIsSuccess_shouldCallPassData() {
        dogsPresenter.fetchURLs(from: url)

        serviceMock.fetchDataArgs?.completion(.success([url]))

        XCTAssert(presentableMock.didCallPassData)
    }

    func test_fetchURLs_whenResultIsFailure_shouldCallDisplayErrorMessage() {
        dogsPresenter.fetchURLs(from: url)

        serviceMock.fetchDataArgs?.completion(.failure(TestError.error))

        XCTAssert(errorPresentableMock.didCallDisplayErrorMessage)
    }

    func test_fetchImage_whenImageCacheHasImage_shouldCallPass() {
        dogsPresenter.imageCache.cache.setObject(testImage, forKey: testNSURL)

        let _ = dogsPresenter.fetchImage(from: url, into: dogCell)

        XCTAssert(presentableMock.didCallPass)
    }

    func test_fetchImage_whenImageCacheHasImage_shouldReturnNil() {
        dogsPresenter.imageCache.cache.setObject(testImage, forKey: testNSURL)

        let suspendableTask = dogsPresenter.fetchImage(from: url, into: dogCell)

        XCTAssertNil(suspendableTask)
    }

    func test_fetchImage_whenServiceResultIsSuccess_shouldCallSet() {
        let _ = dogsPresenter.fetchImage(from: url, into: dogCell)

        serviceMock.fetchImageArgs?.completion(.success(testImage))

        XCTAssert(cacheMock.didCallSet)
    }

    func test_fetchImage_whenServiceResultIsSuccess_shouldCallPass() {
        let _ = dogsPresenter.fetchImage(from: url, into: dogCell)

        serviceMock.fetchImageArgs?.completion(.success(testImage))

        XCTAssert(presentableMock.didCallPass)
    }

    func test_fetchImage_whenServiceResultIsFailure_shouldCallDisplayErrorMessage() {
        let _ = dogsPresenter.fetchImage(from: url, into: dogCell)

        serviceMock.fetchImageArgs?.completion(.failure(TestError.error))

        XCTAssert(errorPresentableMock.didCallDisplayErrorMessage)
    }
}
