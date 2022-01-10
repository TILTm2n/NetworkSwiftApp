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
    
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainPosts()
        
        
    }
    
    func obtainPosts(){
        //сессия подключения к сети
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        session.dataTask(with: url) { (data, response, error) in
            
            
        }.resume()
    }


}

