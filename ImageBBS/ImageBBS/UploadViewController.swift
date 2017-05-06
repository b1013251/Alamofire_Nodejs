import UIKit

import Alamofire

class UploadViewController : UIViewController
    , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image : UIImage!
    
    @IBOutlet weak var previewImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pushUpload(_ sender: Any) {
        if (self.image == nil) {
            print("not selected")
            return
        }
        Alamofire.upload(
            multipartFormData: { (multipartFromData) in
                let jpg = UIImageJPEGRepresentation(self.image, 1.0)!
                multipartFromData.append(jpg,
                                         withName: "images",
                                         fileName: "a.jpg",
                                         mimeType: "image/jpeg")
            },
            to: "http://192.168.116.72:8000/upload",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString {response in
                        print(response)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
    @IBAction func pushSelectImage(_ sender: Any) {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.image = info[UIImagePickerControllerOriginalImage]! as! UIImage
        previewImage.image = self.image
        
        picker.dismiss(animated: true, completion: nil)
    }

    
}
