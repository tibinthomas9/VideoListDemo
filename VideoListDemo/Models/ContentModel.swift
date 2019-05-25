//
//  ContentModel.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 25/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import Foundation


struct ContentBaseModel:Codable{
    var page: ContentPageModel?
}
struct ContentPageModel:Codable{
    var title:String?
    var total_content_items:String?
    var page_num:String?
    var page_size:String?
    var content_items:ContentItemsModel?
    
    enum CodingKeys: String, CodingKey {
        case title
        case total_content_items = "total-content-items"
        case page_num = "page-num"
        case page_size = "page-size"
        case content_items = "content-items"
        
    }
}
struct ContentItemsModel:Codable{
    var content:[ContentModel]?
}
struct ContentModel:Codable{
    var name:String?
    var poster_image:String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case poster_image = "poster-image"
        
    }
}


