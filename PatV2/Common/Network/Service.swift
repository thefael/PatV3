import UIKit

protocol Service {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping ((Result<T, Error>) -> Void))
    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> URLSessionTask
}

class URLSessionService: Service {

    let session: URLSession
    let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchData<T: Decodable>(from url: URL, completion: @escaping ((Result<T, Error>) -> Void)) {
        session.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let object = try self.decoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> URLSessionTask {
        let imageTask = session.dataTask(with: url) { (data, _, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        imageTask.resume()
        return imageTask
    }
}
