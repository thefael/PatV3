import UIKit

protocol BreedsPresenterType {
    var presentable: BreedsPresentable? { get set }
    func fetchData(from url: URL)
    func getInitialButtonImage(for breed: String) -> UIImage?
    func toggleFavorite(breed: String) -> FavoriteState
}

class BreedsPresenter: BreedsPresenterType {
    let service: Service
    let buttonService: FavoriteButtonServiceType
    weak var presentable: BreedsPresentable?

    init(service: Service = URLSessionService(),
         buttonService: FavoriteButtonServiceType = FavoriteButtonService()) {
        self.service = service
        self.buttonService = buttonService
    }

    func fetchData(from url: URL) {
        service.fetchData(from: url) { (result: Result<[String], Error>) in
            switch result {
            case .success(let items):
                let breeds = items.map { name in Breed(name: name) }
                self.presentable?.passBreeds(breeds: breeds)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getInitialButtonImage(for breed: String) -> UIImage? {
        return buttonService.getInitialButtonImage(for: breed)
    }

    func toggleFavorite(breed: String) -> FavoriteState {
        return buttonService.toggleFavorite(breed: breed)
    }
}
