@testable import PatV2
import UIKit

class URLSessionAdapterMock: URLSessionAdaptable {
    var fetchDataArgs: (url: URL, completion: (Result<Data, Error>) -> Void)?
    var fetchImageArgs: (url: URL, completion: (Result<UIImage, Error>) -> Void)?

    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        fetchDataArgs = (url, completion)
    }

    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> SuspendableTask {
        fetchImageArgs = (url, completion)
        return SuspendableTaskMock()
    }
}
