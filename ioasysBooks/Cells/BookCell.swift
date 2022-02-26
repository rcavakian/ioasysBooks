//
//  BookCellTableViewCell.swift
//  ioasysBooks
//
//  Created by Ricardo Camillo Avakian on 22/02/22.
//
import Foundation
import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var bookContentView: UIView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    @IBOutlet weak var bookDetails: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ book: Book) {
        updateBooksTableView(title: book.title, cover: book.imageURL, authors: book.authors, details: book.description)
    }
    
    func updateBooksTableView(title: String?, cover: String?, authors: [String]?, details: String?) {
        self.bookTitle.text = title
        self.bookDetails.text = details
        self.bookAuthors.text = "\(String(describing: authors))"
        guard let coverString = cover else {return}
        urlString = coverString
        
        guard let coverImageURL = URL(string: urlString) else {
            self.bookCover.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.bookCover.image = nil
        
        getImageDataFrom(url: coverImageURL)
        
    }
    
    private func getImageDataFrom(url: URL){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Empty data for book cover")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.bookCover.image = image
                }
            }
        }.resume()
    }
}
