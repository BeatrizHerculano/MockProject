//
//  MockedNetworking.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation


class MockedNetworking: NetworkProtocol{
    func getRequest<T>(request: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let alternativeMocks = readJsonFromBundle(fileName: "alternative")
        let defaultMocks = readJsonFromBundle(fileName: "default")
        
        
        var mockedjsonName: String?
        
        if let alternativeJson = alternativeMocks?[request] {
            mockedjsonName = alternativeJson
        } else {
            mockedjsonName = defaultMocks?[request]
        }
        
        
        guard let json = mockedjsonName else {
            completion(.failure(.noData))
            return
        }
        
        if let response = readJsonFromBundle(fileName: json, responseType: responseType){
            completion(.success(response))
        } else {
            completion(.failure(.decodingError))
        }
        
    }
    
    func readJsonFromBundle(fileName: String) ->  [String: String]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let json = jsonResult as? [String: String] {
                    
                    return json
                }
            } catch {
                print("Error reading JSON file: \(error)")
            }
        }
        return nil
    }
    
    func readJsonFromBundle<T: Decodable>(fileName: String, responseType: T.Type ) ->  T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                    return decodedResponse
                } catch {
                    print("Error reading JSON file: \(error)")
                }
            } catch {
                print("Error reading JSON file: \(error)")
            }
        }
        return nil
    }
    
    
}
