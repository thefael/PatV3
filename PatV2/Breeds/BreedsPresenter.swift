import UIKit

protocol BreedsPresenterType {
    func fetchData(from url: URL, completion: @escaping ((Result<[Breed], Error>) -> Void))
}

class BreedsPresenter: BreedsPresenterType {
    let service: Service

    init(service: Service) {
        self.service = service
    }

    func fetchData(from url: URL, completion: @escaping ((Result<[Breed], Error>) -> Void)) {
        service.fetchData(from: url) { (result: Result<[String], Error>) in
            switch result {
            case .success(let items):
                let breeds = items.map { name in Breed(name: name) }
                completion(.success(breeds))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
