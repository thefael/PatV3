@testable import PatV2
import UIKit

class ImageCacheMock: ImageCacheType {
    var cache: NSCache<NSURL, UIImage>
    var getImageHandler: ((NSURL) -> UIImage?)?

    var didCallSet = false
    var didCallGetImage = false

    init(cache: NSCache<NSURL, UIImage> = NSCache<NSURL, UIImage>()) {
        self.cache = cache
    }

    func set(image: UIImage, forKey key: NSURL) {
        didCallSet = true
    }

    func getImage(forKey key: NSURL) -> UIImage? {
        didCallGetImage = true
        return getImageHandler?(key)
    }
}
