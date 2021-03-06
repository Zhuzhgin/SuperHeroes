//
//  NetworkingNavigator.swift
//  SuperHeroes
//
//  Created by Artem Zhuzhgin on 23.01.2022.
//

import Foundation

enum NetError: Error {
    case invalidUrl
    case noData
    case decodingError
    
}

class NetworkingNavigator {
    
    static let shared = NetworkingNavigator()
    private init() {}
    
    func fetchData(for url: String, complition: @escaping(Result<[Superhero],NetError>)->Void) {
        guard let url = URL(string: url) else {
            complition(.failure(NetError.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                complition(.failure(NetError.noData))
                return
            }
            
            do {
                let superheroes = try JSONDecoder().decode([Superhero].self, from: data)
                DispatchQueue.main.async {
                    complition(.success(superheroes))
                }
                
            } catch {
                complition(.failure(NetError.decodingError))
                
            }
        }.resume()
        
    }
    
    func fetchImage(for url: URL, complition: @escaping(Result< Data, NetError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                complition(.failure(.noData))
            return
            }
            DispatchQueue.main.async {
                complition(.success(data))
            }
        } .resume()
        
        
    }

}
