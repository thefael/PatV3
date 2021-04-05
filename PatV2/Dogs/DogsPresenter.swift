import UIKit

protocol DogsPresenterType {
    var presentable: DogsPresentable? { get set }
    func fetchImages(from url: URL)
}

class DogsPresenter: DogsPresenterType {

    let service: Service
    weak var presentable: DogsPresentable?

    init(service: Service = URLSessionService()) {
        self.service = service
    }

    func fetchImages(from url: URL) {
        service.fetchImages(from: url) { result in
            switch result {
            case .success(let images):
                self.presentable?.passImages(images: images)
            case .failure(let error):
                print(error)
            }
        }
    }
}
