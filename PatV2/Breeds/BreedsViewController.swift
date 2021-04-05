import UIKit

protocol BreedsPresentable: class {
    func passData(data: Decodable)
}

class BreedsViewController: UIViewController {
    let breedsView = BreedsView()
    var presenter: BreedsPresenterType
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
        presenter.presentable = self
        setupView()
        fetchData()
    }

    func setupView() {
        breedsView.tableView.dataSource = dataSource
        breedsView.tableView.delegate = self
        breedsView.tableView.register(BreedCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        dataSource.configureCell = { item, cell in cell.name.text = item.name }
    }

    func fetchData() {
        presenter.fetchData(from: URL.breedsURL)
    }
}

extension BreedsViewController: BreedsPresentable {
    func passData(data: Decodable) {
        guard let breeds = data as? [Breed] else { return }
        DispatchQueue.main.async {
            self.dataSource.items = breeds
            self.breedsView.tableView.reloadData()
        }
    }
}

extension BreedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? BreedCell
        guard let breed = cell?.name.text else { return }
        let dogsVC = DogsViewController(breed: breed)
        navigationController?.pushViewController(dogsVC, animated: true)
    }
}
