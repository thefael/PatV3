import UIKit

class BreedsViewController: UIViewController {
    let breedsView = BreedsView()
    let service: Service

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
    }
}
