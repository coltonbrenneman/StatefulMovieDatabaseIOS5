//
//  NetworkingController.swift
//  StatefulMovieDatabase
//
//  Created by Colton Brenneman on 6/22/23.
//

import UIKit.UIImage

struct NetworkingController {

    func fetch(endpoint: String, with searchTerm: String, completion: @escaping(Result<TopLevelDictionary, ResultError>) -> Void) {
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search") else { completion(.failure(.invalidURL)) ; return }
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.url?.append(path: endpoint)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "d9d57c8ef81b58501e0045ddf733d8a6")
        let searchQueryItem = URLQueryItem(name: "query", value: searchTerm)
        urlRequest.url?.append(queryItems: [apiKeyQueryItem, searchQueryItem])
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) { movieData, movieResponse, error in
            if let error {
                completion(.failure(.thrownError(error))) ; return
            } // End of error
            if movieResponse == nil {
                completion(.failure(.noResponse))
            } // End of respone
            guard let movieData else { completion(.failure(.noData)) ; return }
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: movieData)
                completion(.success(topLevelDictionary))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume() // End of dataTask
    } // End of fetch
    //https://image.tmdb.org/t/p/w500
    func fetchImage(with poserPath: String, completion: @escaping(Result<UIImage, ResultError>) -> Void) {
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500") else { completion(.failure(.invalidURL)) ; return }
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.url?.append(path: poserPath)
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) { imageData, _, error in
            if let error {
                completion(.failure(.thrownError(error))) ; return
            } // End of error
           
            guard let imageData else { completion(.failure(.noData)) ; return }
            
            guard let movieImage = UIImage(data: imageData) else { return }
            completion(.success(movieImage))
        }.resume() // End of dataTask
    } // End of fetchImage
} // End of struct
