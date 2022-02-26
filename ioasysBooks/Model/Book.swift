//
//  Book.swift
//  ioasysBooks
//
//  Created by Ricardo Camillo Avakian on 23/02/22.
//

import Foundation
import UIKit

struct BooksData: Decodable {
    
    let books: [Book]
    
    private enum CodingKeys: String, CodingKey {
        case books = "data"
    }
}

struct Book: Decodable {
    let id, title, description: String?
    let authors: [String]?
    let pageCount: Int?
    let category: String?
    let imageURL: String?
    let isbn10, isbn13, language, publisher: String?
    let published: Int?
    
    enum CodingKeys: String, CodingKey {
            case authors, title
            case description
            case pageCount, category
            case imageURL = "imageUrl"
            case language, isbn10, isbn13, publisher, published, id
        }
}
