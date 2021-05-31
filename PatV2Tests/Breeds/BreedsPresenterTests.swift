@testable import PatV2
import XCTest

class BreedsPresenterTests: XCTestCase {
    let serviceMock = ServiceMock<[String]>()
    let buttonServiceMock = FavoriteButtonServiceMock()
    lazy var breedsPresenter = BreedsPresenter(service: serviceMock, buttonService: buttonServiceMock)
    let presentableMock = BreedsPresentableMock()
    let url = URL(fileURLWithPath: "url")

    func test_fetchData_whenResultIsSuccess_shouldCallPassBreeds_withCorrectObject() {
        breedsPresenter.presentable = presentableMock
        breedsPresenter.fetchData(from: url)

        serviceMock.fetchDataArgs?.completion(.success(BreedsFixture.breedList))
        let breedsPassed = presentableMock.breedsPassed

        XCTAssertEqual(breedsPassed, BreedsFixture.breeds)
    }

    func test_fetchData_whenResultIsFailure_should() {}

    func test_getInitialButtonImage_shouldCallButtonServiceGetInitialButtonImage() {
        let _ = breedsPresenter.getInitialButtonImage(for: "")

        XCTAssert(buttonServiceMock.didCallGetiInitialButtonImage)
    }

    func test_toggleFavorite_shouldCallButtonServiceToggleFavorite() {
        let _ = breedsPresenter.toggleFavorite(breed: "")

        XCTAssert(buttonServiceMock.didCallToggleFavorite)
    }
}

struct BreedsFixture {
    static let breedList = ["a", "b", "c"]
    static let breeds = breedList.map { name in Breed(name: name)}
}


