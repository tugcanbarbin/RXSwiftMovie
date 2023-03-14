//
//  SearchModel.swift
//  imdboV2
//
//  Created by Tugcan barbin on 3/9/23.
//
import Foundation

// MARK: - Search
struct SearchModel: Codable {
    let  totalResults: String
    let response : String
    let search : [ListResult]

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"

    }
}

struct ListResult:Codable {
    let title: String
    let year : String
    let imdbID : String
    let type : String
    let poster : String
    

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
