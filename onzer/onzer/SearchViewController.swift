//
//  SearchViewController.swift
//  onzer
//
//  Created by Alexis Majchrzak on 05/04/2022.
//

import UIKit

struct Album {
    var id: Int
    var name: String
}

struct Artist {
    var id: Int
    var name: String
}

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let baseURL = "https://api.deezer.com/"
    var urlAlbum = "album/302127"
    

    func fetchAlbum(completionHandler: @escaping ([Album]) -> Void) {
        let url = URL(string:baseURL + urlAlbum)!
        var albumArray = [Album]();
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching album: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return
          }

            if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                if let data = json as? [String:AnyObject] {
                    let trueData = data["data"] as? [[String:AnyObject]]
                    print(trueData)
                    for item in trueData! {
                        let name = item["name"] as? String
                        let id = item["id"] as? Int
                        
                        let album = Album(id: id!, name: name!)
                        print(album)
//                        albumArray.append(album)
                    }
                    print(albumArray)
//                    url(albumArray, error)
                    
                }
            }
        })
        task.resume()
      }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

