import UIKit

class BreedsViewController: UIViewController {
    let breedsView = BreedsView()

    override func loadView() {
        view = breedsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
