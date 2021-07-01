import UIKit
import SnapKit

class DogCell: UITableViewCell {
    var dogImageView = UIImageView()
    var suspendableTask: SuspendableTask?

    let presenter = DogsPresenter(service: URLSessionService())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDogImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDogImage() {
        dogImageView.clipsToBounds = true
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dogImageView)
        dogImageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        dogImageView.contentMode = .scaleAspectFill
    }

    
}

extension DogCell {
    override func prepareForReuse() {
        DispatchQueue.main.async { self.dogImageView.image = nil }
        suspendableTask?.suspend()
    }
}
