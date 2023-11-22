//
//  Networking.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case requestFailed
}

protocol NetworkProtocol{
    func getRequest<T: Decodable>(request: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class NetworkManager: NetworkProtocol {
    let apiURL = "https://jsonplaceholder.typicode.com/"
     init() {}
    
    func getRequest<T: Decodable>(request: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: apiURL + request) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
