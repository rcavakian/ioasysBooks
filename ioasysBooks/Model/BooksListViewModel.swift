//
//  BooksListViewModel.swift
//  ioasysBooks
//
//  Created by Ricardo Camillo Avakian on 24/02/22.
//

import Foundation
import UIKit

class BooksListViewModel {
    
    private var apiservice = APIService()
    private var booksList = [Book]()
    
    func fetchBooksListData(completion: @escaping () -> ()) {
        
        apiservice.getBooksData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.booksList = listOf.books
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if booksList.count != 0 {
            return booksList.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Book {
        return booksList[indexPath.row]
    }
}
