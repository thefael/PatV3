import UIKit

class BreedsViewController: UIViewController {
    let breedsView = BreedsView()
    let presenter: BreedsPresenterType
    let dataSource = TableViewDataSource<Breed, BreedCell>()

    init(presenter: BreedsPresenterType = BreedsPresenter(service: URLSessionService())) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = breedsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCell()
        fetchData()
    }

    func setupView() {
        breedsView.tableView.dataSource = dataSource
        breedsView.tableView.register(BreedCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    func configureCell() {
        dataSource.configureCell = { item, cell in cell.name.text = item.name }
    }

    func fetchData() {
        presenter.fetchData(from: URL.breedsURL) { result in
            switch result {
            case .success(let breeds):
                DispatchQueue.main.async {
                    self.dataSource.items = breeds
                    self.breedsView.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
