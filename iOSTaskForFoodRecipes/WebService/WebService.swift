//
//  WebService.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 22/05/2021.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

struct Resource<T: Codable> {
    let url: URL
}

class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: resource.url) { data, _, error in
            guard data == data , error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
