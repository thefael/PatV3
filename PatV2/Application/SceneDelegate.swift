import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let breedsNavController = UINavigationController(rootViewController: BreedsViewController())
        let favoritesNavController = UINavigationController(rootViewController: FavoritesViewController())
        let tabBarController = UITabBarController()
        tabBarController.delegate = tabBarController
        breedsNavController.title = "Breeds"
        favoritesNavController.title = "Favorites"
        tabBarController.viewControllers = [breedsNavController, favoritesNavController]
        window.rootViewController = tabBarController

        self.window = window
        window.makeKeyAndVisible()
    }
}

extension UITabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.2, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
