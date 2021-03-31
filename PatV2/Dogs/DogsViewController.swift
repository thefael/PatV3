import UIKit

class DogsViewController: UIViewController {

    let dogsView = DogsView()

    override func loadView() {
        view = dogsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
