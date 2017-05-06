import UIKit
import Alamofire
import SwiftyJSON

class ListViewController : UIViewController, UITableViewDataSource{
    var images : [Image?] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        
        getList()
        
        
    }
    
    func getList() {
        let baseUrl = "http://192.168.116.72:8000/images/"
        Alamofire.request(baseUrl)
        .responseJSON { response in
            guard let val = response.result.value else {
                print("error!")
                return
            }
            
            let json = JSON(val)
            json.forEach {(_, json) in
                let name: String = json["name"].string!
                let url = baseUrl + json["name"].string!
                let image =
                    Image(name: name, imageUrl: URL(string: url))
                self.images.append(image)
                print(name)
            }
            self.table.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("counon = JSON(val)
            json.forEach {(_, json) in
                let name: String = json["name"].string!
                let url = baseUrl + json["name"].string!
                let image =
                    Image(name: name, imageUrl: URL(string: url))
                self.images.append(image)
                print(name)
            }:" + String(self.images.count))
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("push cell")
        let cell: ImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.setCell(image: images[indexPath.row]!)
        return cell
    }
}
