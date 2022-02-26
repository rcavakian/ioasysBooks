//
//  APIService.swift
//  ioasysBooks
//
//  Created by Ricardo Camillo Avakian on 24/02/22.
//

import Foundation


class APIService {
    
    private var dataTask: URLSessionDataTask?
    private var apiToken: String = ""
    
    func loginIoasysBooks(login: UserLoginModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let url = URL(string: "https://books.ioasys.com.br/api/v1/auth/sign-in") else {
            print("Error creating URL!")
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(login) else {
            print("Error converting model to JSON data!")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                if let httpResponse = response as? HTTPURLResponse {
                    if let token = httpResponse.allHeaderFields["Authorization"] as? String {
                        print("Token: \(token)")
                        
                        self.apiToken = token
                        return
                    }
                }
                let str = String(decoding: data, as: UTF8.self)
                print(str)
            }
          
            }.resume()
        
        }
        
        
        func getBooksData(completion: @escaping (Result<BooksData, Error>) -> Void ) {
            
            let booksDataURL = "https://books.ioasys.com.br/api/v1/books?page=1&amount=10"
            
            guard let url = URL(string: booksDataURL) else {
                print("Error creating URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.setValue("Bearer " + String(apiToken), forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Empty Response")
                    return
                }
                print("Response status code: \(response.statusCode)")
                
                guard let data = data else {
                    print("Empty Data")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(BooksData.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }
            dataTask?.resume()
        }
        
    }
