import UIKit

class BreedsViewController: UIViewController {
    let breedsView = BreedsView()
    let service: Service
    let dataSource = TableViewDataSource<Breed, BreedCell>()

    init(service: Service = URLSessionService()) {
        self.service = service
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
        dataSource.configureCell = { item, cell in
            DispatchQueue.main.async {
                cell.name.text = item.name
            }
        }
    }

    func fetchData() {
        service.fetchData(from: URL.breedsURL) { (result: Result<[String], Error>) in
            switch result {
            case .success(let breedsNames):
                let breeds = breedsNames.map { name in Breed(name: name) }
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
