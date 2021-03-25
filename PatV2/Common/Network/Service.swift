import UIKit

protocol Service {
    func fetchData(from url: URL, completion: @escaping ((Result<Data, Error>) -> Void))
}

class URLSessionService: Service {
    let session = URLSession.shared

    func fetchData(from url: URL, completion: @escaping ((Result<Data, Error>) -> Void)) {
        session.dataTask(with: url) { (data, _, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
