//
//  ViewController.swift
//  NetworkApp
//
//  Created by Eugene on 10.01.2022.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    //конфигурация сесси по умолчанию
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let session = URLSession.shared
    var dataSource = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        obtainPosts()
        
        
    }
    
    func obtainPosts(){
        //сессия подключения к сети
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        //для замыкания объявляем ссылку на self как слабую weak
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            //так как ссылка на self слабая, то необходимо проверить не nil ли объект, и если не nil, то можно использовать
            guard let strongSelf = self else {return}
            
            if error == nil, let parseData = data {
                
                guard let posts = try? strongSelf.decoder.decode([Post].self, from: parseData) else {return}
                
                strongSelf.dataSource = posts
                
                //обновление в любом UI делается в главном потоке
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
                
            }else{
                print("\(error)")
            }
            
        }.resume()
    }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let post = dataSource[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        
        return cell
    }
}

