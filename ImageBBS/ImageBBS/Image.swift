import Foundation

class Image {
    var name: String
    var imageUrl: URL?
    
    init(name: String, imageUrl: URL?) {
        self.name = name
        self.imageUrl = imageUrl
    }
}
