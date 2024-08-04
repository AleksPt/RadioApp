//
//  NetworkService.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 04.08.2024.
//

import Foundation


final class NetworkService {
    
    static let shared = NetworkService()
    
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private let popularURL = Link.popular.url
    private let allStationsURL = Link.allStations.url
    
    
    //MARK: - Popular
    
    func fetchPopular(_ completion: @escaping (Result<[Station], NetworkError>) -> Void) {
        guard let url = URL(string: popularURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { data, _, error in
            guard let data, error != nil else {
                print(error?.localizedDescription ?? "no error")
                completion(.failure(.noData))
                return
            }
            
            do {
                let station = try self.decoder.decode(Station.self, from: data)
                completion(.success([station]))
                print(station)
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    //MARK: - All Stations
    
    func fetchAllStations(_ completion: @escaping (Result<[Station], NetworkError>) -> Void) {
        guard let url = URL(string: allStationsURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { data, _, error in
            guard let data, error != nil else {
                print(error?.localizedDescription ?? "no error")
                completion(.failure(.noData))
                return
            }
            
            do {
                let station = try self.decoder.decode(Station.self, from: data)
                completion(.success([station]))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
