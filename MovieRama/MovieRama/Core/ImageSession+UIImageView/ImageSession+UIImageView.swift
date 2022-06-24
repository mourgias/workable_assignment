//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit
import Combine

private var kSessionKey = "CacheSession"

public extension UIImageView {
    
    var operation : AnyCancellable? {
        get {
            return objc_getAssociatedObject(self, &kSessionKey) as? AnyCancellable
        }
        set {
            objc_setAssociatedObject(self, &kSessionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setImage(with imageURL: String?, placeholder: UIImage? = nil, cacheMethod: CacheMethod = .memory, completionBlock: ((Bool) -> Void)? = nil) {
        self.image = placeholder
        
        guard let imageURL = imageURL else { completionBlock?(false) ; return }
        
        if let image = cacheMethod.getImage(for: imageURL) {
            self.image = image
            completionBlock?(true)
        } else {
            var urlObject: URL?
            
            if let safeURL = URL(string : imageURL) {
                urlObject = safeURL
            } else if let percentEncodedUrl = URL(string : imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
                urlObject = percentEncodedUrl
            }
            
            guard let url = urlObject else {
                print("Image Cacher: String URL provided for image: \(self.image?.description ?? "") is not valid URL")
                completionBlock?(false)
                return
            }
            
            operation = URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(handleResponse)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case let .failure(error):
                        completionBlock?(false)
                        print(error.localizedDescription)
                    }
                } receiveValue: { image in
                    if let image = image {
                        cacheMethod.saveImage(image, for: imageURL)
                        self.image = image
                        completionBlock?(true)
                    }
                }
        }
    }
    
    private func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
}
