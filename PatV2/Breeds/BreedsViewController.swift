import UIKit

protocol BreedsPresentable: class {
    func passBreeds(breeds: [Breed])
}

class BreedsViewController: UITableViewController {
    var presenter: BreedsPresenterType
    let buttonPresenter = FavoriteButtonPresenter()
    let dataSource = TableViewDataSource<Breed, BreedCell>()

    init(presenter: BreedsPresenterType = BreedsPresenter(service: URLSessionService())) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.presentable = self
        setupTableView()
        presenter.fetchData(from: URL.breedsURL)
    }

    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.rowHeight = 44
        tableView.delegate = self
        tableView.register(BreedCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        dataSource.configureCell = { [weak self] item, cell in
            guard let self = self else { return }
            let breed = item.name.capitalizingFirstLetter()
            cell.nameLabel.text = breed
            cell.name = breed
            cell.favoriteButton.setImage(self.buttonPresenter.getInitialButtonImage(for: breed), for: .normal)
            cell.delegate = self
        }
    }
}

extension BreedsViewController: BreedsPresentable {
    func passBreeds(breeds: [Breed]) {
        DispatchQueue.main.async {
            self.dataSource.items = breeds
            self.tableView.reloadData()
        }
    }
}

extension BreedsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? BreedCell
        guard let breed = cell?.nameLabel.text?.lowercased() else { return }
        let dogsVC = DogsViewController(breed: breed)
        navigationController?.pushViewController(dogsVC, animated: true)
    }
}

extension BreedsViewController: FavoriteButtonDelegate {
    func toggleFavorite(breed: String) -> FavoriteState {
        return buttonPresenter.toggleFavorite(breed: breed)
    }
}
