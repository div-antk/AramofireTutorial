//
//  ArticleViewController.swift
//  AramofireTutorial
//
//  Created by Takuya Ando on 2021/03/05.
//

import UIKit
import Alamofire

class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    
    var articles = [ArticleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // NavigationBarのタイトル
        title = "新着"
        
        getArticles()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let article = articles[indexPath.row]
        
        let title = cell.viewWithTag(1) as! UILabel
        title.text = article.title

        return cell
    }
    
    func getArticles() {
        AF.request(
            "https://qiita.com/api/v2/items",
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil
        ).responseJSON { (response) in

            let decoder: JSONDecoder = JSONDecoder()
            do {
                let articles: [ArticleModel] = try
                    decoder.decode([ArticleModel].self,
                                   from: response.data!)
                self.articles = articles
                self.tableView.reloadData()
                
            } catch {
                print("error")
            }
        }
    }
}
