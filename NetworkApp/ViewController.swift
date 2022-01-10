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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //сессия подключения к сети
        let session = URLSession(configuration: sessionConfiguration)
        
    }


}

