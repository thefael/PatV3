import UIKit

protocol URLSessionAdaptable {
    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> URLSessionTask
}

class URLSessionAdapter: URLSessionAdaptable {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data =  data {
                completion(.success(data))
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
