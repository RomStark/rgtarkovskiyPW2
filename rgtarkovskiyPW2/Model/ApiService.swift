//
//  ApiService.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 03.11.2022.
//

import Foundation

final class ApiService {
    static let shared = ApiService()
    
   
    func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void ) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=252c278fdee440e38d5771cac96032a2")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
//                print(String(decoding: data!, as: UTF8.self))
                let obj = try JSONDecoder().decode(News.self, from: data!)
                completion(.success(obj.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
