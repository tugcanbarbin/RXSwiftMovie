//
//  MovieViewModel.swift
//  imdboV2
//
//  Created by Tugcan barbin on 3/9/23.
//
import Foundation
import RxSwift
import RxCocoa


class MovieViewModel {
    
    
    public let movies : PublishSubject<[ListResult]> = PublishSubject()
    public let movie : PublishSubject<DetailedResult> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    
    public func requestListData(name : String){
        let url = "https://www.omdbapi.com/?apikey=b2268941&s=" + name
        Webservice().downloadMovieList(url: URL(string: url)!) { listResult in
            switch listResult {
            case .success(let movies):
                print(movies)
                self.movies.onNext(movies)
            case .failure(let failure):
                switch failure {
                case .parsingEror:
                    self.error.onNext("Cannot parse your data")
                case .serverError:
                    self.error.onNext("Cannot get your data at all")
                }
            }
        }
    }
    
    
    public func requestMovieData(id : String){
        var url = "https://www.omdbapi.com/?apikey=b2268941&i=" + id
        Webservice().downloadMovie(url: URL(string: url )!) { searchResult in
            switch searchResult {
            case .success(let movie):
                print(movie)
                self.movie.onNext(movie)
            case .failure(let failure):
                switch failure {
                case .parsingEror:
                    self.error.onNext("Cannot parse your data")
                case .serverError:
                    self.error.onNext("Cannot get your data at all")
                }
            }
        }
        
        
    }
}
