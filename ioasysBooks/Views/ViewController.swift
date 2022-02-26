//
//  ViewController.swift
//  ioasysBooks
//
//  Created by Ricardo Camillo Avakian on 07/02/22.
//
import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var rectangaleView: UIImageView!
    @IBOutlet weak var booksLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    
    
    private lazy var loginIoasysBooks = APIService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.clipsToBounds = true
        loginView.layer.cornerRadius = 16
        loginView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        emailTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
        enterButton.layer.cornerRadius = 8
        passwordTextField.enablePasswordToggle()
                
    }
    
    func displayAlert() {
        let dialogMessage = UIAlertController(title: "Erro no login", message: "Usuário ou senha inválida.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
        })
        
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }

    func openBooksListView() {
        let booksListView = BooksListView()
        present(booksListView, animated: true, completion: nil)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let login = UserLoginModel(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        loginIoasysBooks.loginIoasysBooks(login: login) { (result) in
            switch result {
            case .success(true):
                self.openBooksListView()
            case .success(false):
                self.displayAlert()
            case .failure(_):
                return
            }
            
        }
    }
}
