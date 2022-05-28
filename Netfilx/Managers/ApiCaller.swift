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
        guard let url = URL(string: "\(Constants.baseURL)3/trending/movie/day?api_key=\(Constants.API_KEY)")else{return}
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
    
    func getTrendingTv(completion: @escaping (Result< [Tv] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/trending/tv/day?api_key=\(Constants.API_KEY)")else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {return}
            do {
                let result = try JSONDecoder().decode(TrendingTv.self, from: data)
                completion(.success(result.results))
                print(result)
            } catch  {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(Result<[Movie] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data  = data , error == nil else { return }
            do {
                let result = try JSONDecoder().decode(TrendingMovies.self, from: data)
                completion(.success(result.results))
                print(result)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping(Result<[Movie] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data  = data , error == nil else { return }
            do {
                let result = try JSONDecoder().decode(TrendingMovies.self, from: data)
                completion(.success(result.results))
                print(result)
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingMovies.self, from: data)
                completion(.success(result.results))
                print(result)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

