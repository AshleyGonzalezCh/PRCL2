import Foundation
 
class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "http://161.97.164.147:8000"  // Cambia esta URL a la de tu API
 
    func searchWorks(query: String, completion: @escaping ([Work]?) -> Void) {
        let urlString = "\(baseURL)/search?author=\(query)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode([String: [Work]].self, from: data)
                completion(result["results"])
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
    }
 
    func fetchWorkDetails(workID: Int, completion: @escaping ([Chapter]?) -> Void) {
        let urlString = "\(baseURL)/work/\(workID)/chapters"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let capitulos = try JSONDecoder().decode([Chapter].self, from: data)
                completion(capitulos)
            } catch {
                print("Error decoding work details: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
