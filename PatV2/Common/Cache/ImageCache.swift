import UIKit

protocol ImageCacheType {
    var cache: NSCache<NSURL, UIImage> { get set }
    func set(image: UIImage, forKey key: NSURL)
    func getImage(forKey key: NSURL) -> UIImage?
}

class ImageCache: ImageCacheType {
    var cache = NSCache<NSURL, UIImage>()

    func set(image: UIImage, forKey key: NSURL) {
        cache.setObject(image, forKey: key)
    }

    func getImage(forKey key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }
}
