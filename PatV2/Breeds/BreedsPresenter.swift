import UIKit

protocol BreedsPresenterType {
    var presentable: BreedsPresentable? { get set }
    func fetchData(from url: URL)
}

class BreedsPresenter: BreedsPresenterType {
    let service: Service
    weak var presentable: BreedsPresentable?

    init(service: Service) {
        self.service = service
    }

    func fetchData(from url: URL) {
        service.fetchData(from: url) { (result: Result<[String], Error>) in
            switch result {
            case .success(let items):
                let breeds = items.map { name in Breed(name: name) }
                self.presentable?.passData(data: breeds)
            case .failure(let error):
                print(error)
            }
        }
    }
}
