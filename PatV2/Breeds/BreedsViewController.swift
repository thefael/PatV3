import UIKit

protocol BreedsPresentable: class {
    func passData(data: Decodable)
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
        dataSource.configureCell = { item, cell in
            let breed = item.name.capitalizingFirstLetter()
            cell.name.text = breed
            cell.favoriteButton.setImage(self.buttonPresenter.getInitialButtonImage(for: breed), for: .normal)
            cell.favoriteButton.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
        }
    }

    @objc func onTap(_ sender: UIButton) {
        guard let cell = sender.superview as? BreedCell else { return }
        guard let breed = cell.name.text else { return }
        buttonPresenter.tapButton(sender, for: breed)
    }
}

extension BreedsViewController: BreedsPresentable {
    func passData(data: Decodable) {
        guard let breeds = data as? [Breed] else { return }
        DispatchQueue.main.async {
            self.dataSource.items = breeds
            self.tableView.reloadData()
        }
    }
}

extension BreedsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? BreedCell
        guard let breed = cell?.name.text?.lowercased() else { return }
        let dogsVC = DogsViewController(breed: breed)
        navigationController?.pushViewController(dogsVC, animated: true)
    }
}
