//
//  FavoriteViewController.swift
//  ioasysBooks
//
//  Created by Ricardo Camillo Avakian on 23/02/22.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var favoriteBooks: [Book] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        searchBar.layer.cornerRadius = 4
        
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteBookCell", for: indexPath) as? FavoriteBookCell else {
            return UITableViewCell()
        }
        
//        let favoriteBook = favoriteBooks[indexPath.row]
        
//        cell.setBook(book: favoriteBook)
        
        return cell
    }
}
