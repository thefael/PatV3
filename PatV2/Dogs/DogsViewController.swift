import UIKit

protocol DogsPresentable: AnyObject {
    func passData(urls: [URL])
    func pass(image: UIImage, to cell: DogCell)
    func presentError(_ error: Error)
}

class DogsViewController: UIViewController {
    let dogsView = DogsView()
    var presenter: DogsPresenterType
    let dataSource = TableViewDataSource<URL, DogCell>()
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
        presenter.fetchURLs(from: URL.dogImagesURL(breed: breed))
        setupView()
    }

    func setupView() {
        dogsView.tableView.dataSource = dataSource
        dogsView.tableView.rowHeight = 200
        dogsView.tableView.register(DogCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        dataSource.configureCell = { url, cell in
            cell.suspendableTask = self.presenter.fetchImage(from: url, into: cell)
//            cell.fetchImage(url: url)
        }
    }
}

extension DogsViewController: DogsPresentable {
    func passData(urls: [URL]) {
        DispatchQueue.main.async {
            self.dataSource.items = urls
            self.dogsView.tableView.reloadData()
        }
    }

    func pass(image: UIImage, to cell: DogCell) {
        DispatchQueue.main.async {
            cell.dogImageView.image = image
        }
    }

    func presentError(_ error: Error) {
        DispatchQueue.main.async {
            self.dogsView.alertView.title = "An error occurred"
            self.dogsView.alertView.message = error.localizedDescription
            self.dogsView.alertView.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                print("Dismiss")
            }))

            self.present(self.dogsView.alertView, animated: true)
        }
    }
}
