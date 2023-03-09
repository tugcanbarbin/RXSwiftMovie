//
//  Webservice.swift
//  imdboV2
//
//  Created by Tugcan barbin on 3/9/23.
//
import Foundation

public enum movieError : Error {
    case serverError
    case parsingEror
}

class Webservice {
    
    func downloadMovieList(url: URL, completion: @escaping (Result<[SearchResult],movieError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                
                let movieList = try? JSONDecoder().decode([SearchResult].self, from: data)
                
                if let movieList = movieList {
                    completion(.success(movieList))
                } else {
                    completion(.failure(.parsingEror))
                }
                
            }
            
        }.resume()
        
    }
    func downloadMovie(url: URL, completion: @escaping (Result<DetailedResult,movieError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                
                let movie = try? JSONDecoder().decode(DetailedResult.self, from: data)
                
                if let movie = movie {
                    completion(.success(movie))
                } else {
                    completion(.failure(.parsingEror))
                }
                
            }
            
        }.resume()
        
    }
}
