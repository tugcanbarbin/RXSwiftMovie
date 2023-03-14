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
    
    func downloadMovieList(url: URL, completion: @escaping (Result<[ListResult],movieError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                do {
                    print(String(data: data, encoding: String.Encoding.utf8) as String?)
                    //let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//                    let searchResults = json!.values[json!.index(forKey: "Search")!]
//                    let searchResultsData =  try JSONSerialization.data(withJSONObject: searchResults, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
                    
                    //print(searchResults)
                    let result = try? JSONDecoder().decode(SearchModel.self, from: data)
                    let movieList = result?.search
                    
                    if let movieList = movieList {
                        completion(.success(movieList))
                    } else {
                        completion(.failure(.parsingEror))
                    }
                } catch {
                    print("json conversion error")
                }

            }
            
        }.resume()
        
    }
    func downloadMovie(url: URL, completion: @escaping (Result<DetailedResult,movieError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                do {
                    print(String(data: data, encoding: String.Encoding.utf8) as String?)
                    
                    let movie = try? JSONDecoder().decode(DetailedResult.self, from: data)
                    
                    if let movie = movie {
                        completion(.success(movie))
                    } else {
                        completion(.failure(.parsingEror))
                    }
                } catch {
                    print("json conversion error")
                }

            }
            
        }.resume()
        
    }
    
}
