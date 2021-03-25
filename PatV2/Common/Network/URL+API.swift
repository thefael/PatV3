import Foundation

extension URL {
    private static var baseURL: URL {
        guard let url = URL(string: "https://hidden-crag-71735.herokuapp.com/api/") else { fatalError("Wrong baseURL!") }
        return url
    }

    static var breedsURL: URL {
        let url = baseURL.appendingPathComponent("breeds")
        return url
    }
}
