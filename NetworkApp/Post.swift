//
//  Post.swift
//  NetworkApp
//
//  Created by Eugene on 10.01.2022.
//

import Foundation

//протокол Codable позволяет кодировать(Encoding) и декодировать(Decoding) данные
struct Post: Codable{
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey{
        case userId
        //если полу в модели не совпадает с полем в JSON-объекте, то можно написать так
        case postId = "id"
        case title
        case body
    }
}
