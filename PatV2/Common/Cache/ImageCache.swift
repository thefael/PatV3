import UIKit

protocol ImageCacheType {
    var cache: NSCache<NSURL, UIImage> { get set }
    func set(image: UIImage, forKey key: NSURL)
    func getImage(forKey key: NSURL) -> UIImage?
}

class ImageCache: ImageCacheType {
    var cache: NSCache<NSURL, UIImage>

    init(cache: NSCache<NSURL, UIImage> = NSCache<NSURL, UIImage>()) {
        self.cache = cache
    }

    func set(image: UIImage, forKey key: NSURL) {
        cache.setObject(image, forKey: key)
    }

    func getImage(forKey key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }
}
