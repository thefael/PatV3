import UIKit

protocol Service {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping ((Result<T, Error>) -> Void))
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
            print(url)
            if let data = data {
                do {
                    let object = try self.decoder.decode(T.self, from: data)
                    print(object)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
