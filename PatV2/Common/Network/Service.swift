import UIKit

protocol Service {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping ((Result<T, Error>) -> Void))
    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> URLSessionTask
}

class URLSessionService: Service {

    let session: URLSessionAdaptable
    let decoder: JSONDecoder

    init(session: URLSessionAdaptable = URLSessionAdapter(), decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchData<T: Decodable>(from url: URL, completion: @escaping ((Result<T, Error>) -> Void)) {
        session.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let obj = try self.decoder.decode(T.self, from: data)
                    completion(.success(obj))
                } catch { completion(.failure(error)) }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> URLSessionTask {
        let imageTask = session.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return imageTask
    }
}
