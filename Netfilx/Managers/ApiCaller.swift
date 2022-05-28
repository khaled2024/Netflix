//
//  ApiCaller.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 28/05/2022.
//

import Foundation


struct Constants {
    static let API_KEY = "4e64d9425b76606aee7f62bfe7fbc67b"
    static let baseURL = "https://api.themoviedb.org/"
}
enum APIError {
    case failedTOGetData
}
class ApiCaller{
    static let shared = ApiCaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie] , Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/trending/all/day?api_key=\(Constants.API_KEY)")else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingMovies.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
