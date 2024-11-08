import Foundation
 
class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "http://tu-api-url"  // Cambia esta URL a la de tu API
 
    func searchWorks(query: String, completion: @escaping ([Work]?) -> Void) {
        let urlString = "\(baseURL)/search?any_field=\(query)"
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
 
    func fetchWorkDetails(workID: Int, completion: @escaping (Work?) -> Void) {
        let urlString = "\(baseURL)/work/\(workID)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let work = try JSONDecoder().decode(Work.self, from: data)
                completion(work)
            } catch {
                print("Error decoding work details: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
