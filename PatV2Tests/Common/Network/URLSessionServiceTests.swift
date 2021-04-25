@testable import PatV2
import XCTest
import Foundation

class URLSessionServiceTests: XCTestCase {
    let sessionMock = URLSessionAdapterMock()
    lazy var service = URLSessionService(session: sessionMock)

    let url = URL(fileURLWithPath: "url")
    var fetchDataResult: Result<JSONObject, Error>?
    var fetchImageResult: Result<UIImage, Error>?

    func test_fetchData_whenResultIsSuccess_shouldCallCompletionWithCorrectObject() {
        fetchData()
        guard let data = JSONObject().data else {
            XCTFail()
            return
        }

        sessionMock.fetchDataArgs?.completion(.success(data))
        let decodedData = try? JSONDecoder().decode(JSONObject.self, from: data)
        let obj = try? fetchDataResult?.get()

        XCTAssertEqual(obj, decodedData)
    }

    func test_fetchData_whenResultIsFailure_shouldCallCompletionWithCorrectError() {
        fetchData()

        sessionMock.fetchDataArgs?.completion(.failure(TestError.error))
        var error: TestError?
        do { let _ = try fetchDataResult?.get() }
        catch let e {
            error = e as? TestError
        }

        XCTAssertEqual(error, TestError.error)
    }

    func test_fetchData_whenResultReturnsInvalidData_shouldCallCompletionWithCorrectError() {
        fetchData()
        let invalidData = Data()

        sessionMock.fetchDataArgs?.completion(.success(invalidData))
        var error: CommonError?
        do { let _ = try fetchDataResult?.get() }
        catch let e { error = e as? CommonError }

        XCTAssertEqual(error, CommonError.failedToDecodeData)
    }

    func test_fetchImage_whenResultIsSuccess_shouldCallCompletionWithImage() {
        fetchImage()
        guard let validImage = UIImage(systemName: "heart") else { XCTFail(); return }

        sessionMock.fetchImageArgs?.completion(.success(validImage))
        let image = try? fetchImageResult?.get()

        XCTAssertEqual(image, validImage)
    }

    func test_fetchImage_whenResultIsFailure_shouldCallCompletionWithCorrectError() {
        fetchImage()

        sessionMock.fetchImageArgs?.completion(.failure(TestError.error))
        var error: TestError?
        do { let _ = try fetchImageResult?.get() }
        catch let e { error = e as? TestError }

        XCTAssertEqual(error, TestError.error)
    }

    private func fetchData() {
        service.fetchData(from: url) { result in
            self.fetchDataResult = result
        }
    }

    private func fetchImage() {
        let _ = service.fetchImage(from: url) { result in
            self.fetchImageResult = result
        }
    }
}

enum TestError: Error {
    case error
}

struct JSONObject: Codable, Equatable {
    let integer: Int

    init(_ integer: Int = 1) {
        self.integer = integer
    }

    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}
