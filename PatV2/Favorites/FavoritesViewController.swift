import UIKit

class FavoritesViewController: UITableViewController {
    let favoritesCache: FavoriteBreedsCacheType
    let dataSource = TableViewDataSource<String, FavoriteCell>()

    init(cache: FavoriteBreedsCacheType = FavoriteBreedsCache.shared) {
        self.favoritesCache = cache
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        dataSource.items = favoritesCache.getFavorites().sorted { $0 < $1 }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.configureCell = { item, cell in cell.favoriteLabel.text = item }
        tableView.dataSource = dataSource
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}
