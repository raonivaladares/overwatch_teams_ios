import UIKit

// https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
// https://medium.com/journey-of-one-thousand-apps/caching-images-in-swift-e909a8e5db17

extension UIImageView {
    static let imageCache = NSCache<NSString, UIImage>()
    
    private func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            image = cachedImage
        } else {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200,
                    
                    let mimeType = response?.mimeType,
                    mimeType.hasPrefix("image"),
                    
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                
                DispatchQueue.main.async() {
                    UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                }
            }.resume()
        }
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
