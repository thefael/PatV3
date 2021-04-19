import UIKit

class FavoritesViewController: UIViewController {
    let favoritesView = BreedsView(frame: Constants.screen)
    let cache = FavoriteBreedsCache.shared
    let dataSource = TableViewDataSource<String, FavoriteCell>()

    override func loadView() {
        self.view = favoritesView
    }

    override func viewWillAppear(_ animated: Bool) {
        dataSource.items = cache.cache.sorted { $0 < $1 }
        favoritesView.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.configureCell = { item, cell in cell.favoriteLabel.text = item }
        favoritesView.tableView.dataSource = dataSource
        favoritesView.tableView.register(FavoriteCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}
