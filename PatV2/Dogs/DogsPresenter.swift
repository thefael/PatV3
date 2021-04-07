import UIKit

protocol DogsPresenterType {
    var presentable: DogsPresentable? { get set }
    func fetchURLs(from url: URL)
    func fetchImage(from url: URL, into: DogCell)
}

class DogsPresenter: DogsPresenterType {

    let service: Service
    weak var presentable: DogsPresentable?

    init(service: Service = URLSessionService()) {
        self.service = service
    }

    func fetchURLs(from url: URL) {
        service.fetchData(from: url) { (result: Result<[URL], Error>) in
            switch result {
            case .success(let urls):
                self.presentable?.passData(urls: urls)
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchImage(from url: URL, into cell: DogCell) {
        service.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                self.presentable?.pass(image: image, to: cell)
            case .failure(let error):
                print(error)
            }
        }
    }
}
