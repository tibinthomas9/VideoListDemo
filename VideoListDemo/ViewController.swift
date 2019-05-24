//
//  ViewController.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 23/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import UIKit
import DataFetcher

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let url = Bundle.main.url(forResource: "CONTENTLISTINGPAGE-PAGE1", withExtension: "json"){
            let request = JsonRequest<contentBaseModel>.init(url: url)
            request.load { (model) in
                print(model)
            }
            
        }
    }


}
struct contentBaseModel:Codable{
    var page: contentPageModel?
}
struct contentPageModel:Codable{
    var title:String?
    var total_content_items:String?
    var page_num:String?
    var page_size:String?
    var content_items:contentItemsModel?
    
    enum CodingKeys: String, CodingKey {
        case title
        case total_content_items = "total-content-items"
        case page_num = "page-num"
        case page_size = "page-size"
        case content_items = "content-items"
        
    }
}
struct contentItemsModel:Codable{
    var content:[contentModel]?
}
struct contentModel:Codable{
    var name:String?
    var poster_image:String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case poster_image = "poster-image"
        
    }
}

