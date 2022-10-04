//
//  NetworkManager.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 4.10.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let url = "https://randomuser.me/api/"
    
    func getRandomProfile(completion: @escaping (Result<FakeProfile, FPError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
             let decoder = JSONDecoder()
                let profile = try decoder.decode(FakeProfile.self, from: data)
                completion(.success(profile))
            }catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
}
