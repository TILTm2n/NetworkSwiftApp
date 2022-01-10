//
//  ViewController.swift
//  NetworkApp
//
//  Created by Eugene on 10.01.2022.
//

import UIKit

class ViewController: UIViewController {
    //конфигурация сесси по умолчанию
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainPosts()
        
        
    }
    
    func obtainPosts(){
        //сессия подключения к сети
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let stringSelf = self else {return}
            if error == nil, let parseData = data {
                
                let posts = try? stringSelf.decoder.decode([Post].self, from: parseData)
                print("Posts: \(posts?.count)")
            }else{
                print("\(error)")
            }
            
        }.resume()
    }


}

