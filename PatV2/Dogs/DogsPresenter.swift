import UIKit

class DogsPresenter {

    let service: Service

    init(service: Service = URLSessionService()) {
        self.service = service
    }

    func fetchImage(url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        service.fetchImage(from: url) { (result: Result<UIImage, Error>) in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
