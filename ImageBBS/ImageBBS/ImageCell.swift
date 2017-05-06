import UIKit

class ImageCell : UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    
    func setCell(image: Image) {
        print("setcell")
        do {
            let imageData : Data = try Data(contentsOf: image.imageUrl!, options: Data.ReadingOptions.dataReadingMapped)
            self.cellImageView.image = UIImage(data: imageData)
        } catch {
            print("other error")
        }
    }
}
