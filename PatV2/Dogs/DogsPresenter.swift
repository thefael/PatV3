import UIKit

protocol DogsPresenterType {
    var presentable: DogsPresentable? { get set }
    var errorPresentable: PresenterErrorsPresetable? { get set }
    func fetchURLs(from url: URL)
    func fetchImage(from url: URL, into cell: DogCell) -> SuspendableTask?
}

class DogsPresenter: DogsPresenterType {

    let service: Service
    let imageCache: ImageCacheType
    weak var presentable: DogsPresentable?
    weak var errorPresentable: PresenterErrorsPresetable?

    init(service: Service = URLSessionService(), cache: ImageCacheType = ImageCache()) {
        self.service = service
        self.imageCache = cache
    }

    func fetchURLs(from url: URL) {
        service.fetchData(from: url) { (result: Result<[URL], Error>) in
            switch result {
            case .success(let urls):
                self.presentable?.passData(urls: urls)
            case .failure(let error):
                self.errorPresentable?.displayErrorMessage(error: error)
            }
        }
    }

    func fetchImage(from url: URL, into cell: DogCell) -> SuspendableTask? {
        if let image = imageCache.cache.object(forKey: url as NSURL) {
            self.presentable?.pass(image: image, to: cell)
            return nil

        } else {
            let task = service.fetchImage(from: url) { result in
                switch result {
                case .success(let image):
                    self.imageCache.set(image: image, forKey: url as NSURL)
                    self.presentable?.pass(image: image, to: cell)
                case .failure(let error):
                    self.errorPresentable?.displayErrorMessage(error: error)
                }
            }
            return task
        }
    }
}
