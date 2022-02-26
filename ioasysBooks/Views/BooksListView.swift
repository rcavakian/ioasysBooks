//
//  BooksListView.swift
//  ioasysBooks
//
//  Created by Ricardo Camillo Avakian on 23/02/22.
//
import Foundation
import UIKit

class BooksListView: UIViewController {
   
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = BooksListViewModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookTableView.delegate = self
        searchBar.layer.cornerRadius = 8
        loadBooksListData()

    }
    
    private func loadBooksListData() {
        viewModel.fetchBooksListData { [ weak self ] in
            self?.bookTableView.dataSource = self
            self?.bookTableView.reloadData()
            
        }
    }
}

extension BooksListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        
        let book = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(book)
        
        return cell
    }
}
