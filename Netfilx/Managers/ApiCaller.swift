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
    static let Youtube_KEY = "AIzaSyAbPTERkCXbPre9ADnYkdPS4ftvFuGcJPA"
    static let YouTubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}
enum APIError: Error {
    case failedTOGetData
}
class ApiCaller{
    static let shared = ApiCaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title] , Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/trending/movie/day?api_key=\(Constants.API_KEY)")else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(APIError.failedTOGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completion: @escaping (Result< [Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/trending/tv/day?api_key=\(Constants.API_KEY)")else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {return}
            do {
                let result = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(APIError.failedTOGetData))
            }
            
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data  = data , error == nil else { return }
            do {
                let result = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedTOGetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping(Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data  = data , error == nil else { return }
            do {
                let result = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedTOGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func discoverMovies(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func search(with query: String , completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        guard let url = URL(string: "\(Constants.baseURL)3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func getMovie(with query: String , completion: @escaping (Result< VideoElement , Error>)-> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        guard let url = URL(string: "\(Constants.YouTubeBaseUrl)q=\(query)&key=\(Constants.Youtube_KEY)")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let result  = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                completion(.success(result.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}

