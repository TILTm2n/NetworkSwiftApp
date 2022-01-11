//
//  NetworlManager.swift
//  NetworkApp
//
//  Created by Eugene on 11.01.2022.
//

import Foundation

//создание параметризованного enum
enum ObtainPostsResult{
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager{
    
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let session = URLSession.shared
    //возможно сделать два completion блока для обработки асинхронной операции
    func obtainPosts(completion: @escaping (ObtainPostsResult) -> Void){
        //сессия подключения к сети
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        //для замыкания объявляем ссылку на self как слабую weak
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            var result: ObtainPostsResult
            
            //defer сработает в любом случев при выходе из блока этой функции
            defer{
                //необходимо вернуть в главном потоке
                DispatchQueue.main.async{
                    completion(result)
                }
            }
            
            //так как ссылка на self слабая, то необходимо проверить не nil ли объект, и если не nil, то можно использовать
            guard let strongSelf = self else {
                result = .success(posts: [])
                //либо можно вернуть свою ошибку о том что что-то пошло не так
                return
            }
            
            if error == nil, let parseData = data {
                
                guard let posts = try? strongSelf.decoder.decode([Post].self, from: parseData) else {
                    //если не получилось спарсить то положить пустой массив
                    result = .success(posts: [])
                    return
                }
                
                result = .success(posts: posts)
                
            }else{
                result = .failure(error: error!)
            }
            
        }.resume()
    }
    
}
