import UIKit

protocol DogsPresentable: class {
    func passImages(images: [UIImage])
}

class DogsViewController: UIViewController {
    let dogsView = DogsView()
    var presenter: DogsPresenterType
    let dataSource = TableViewDataSource<UIImage, DogCell>()
    let breed: String

    init(presenter: DogsPresenterType = DogsPresenter(), breed: String) {
        self.presenter = presenter
        self.breed = breed
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = dogsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.presentable = self
        presenter.fetchImages(from: URL.dogImagesURL(breed: breed))
        setupView()
    }

    func setupView() {
        dogsView.tableView.dataSource = dataSource
        dogsView.tableView.rowHeight = 200
        dogsView.tableView.register(DogCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        dataSource.configureCell = { image, cell in
            DispatchQueue.main.async { cell.dogImageView.image = image }
        }
    }
}

extension DogsViewController: DogsPresentable {
    func passImages(images: [UIImage]) {
        DispatchQueue.main.async {
            self.dataSource.items = images
            self.dogsView.tableView.reloadData()
        }
    }
}
