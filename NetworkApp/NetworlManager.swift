//
//  NetworlManager.swift
//  NetworkApp
//
//  Created by Eugene on 11.01.2022.
//

import Foundation

enum ObtainPostsResult{
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager{
    
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let session = URLSession.shared
    //возможно сделать два completion блока для обработки асинхронной операции
    func obtainPosts(completion: @escaping ([Post]) -> Void, failureCompletion: @escaping (Error) -> Void){
        //сессия подключения к сети
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        //для замыкания объявляем ссылку на self как слабую weak
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            //так как ссылка на self слабая, то необходимо проверить не nil ли объект, и если не nil, то можно использовать
            guard let strongSelf = self else {return}
            
            if error == nil, let parseData = data {
                
                guard let posts = try? strongSelf.decoder.decode([Post].self, from: parseData) else {return}
                
            }else{
                failureCompletion(error!)
            }
            
        }.resume()
    }
    
}
