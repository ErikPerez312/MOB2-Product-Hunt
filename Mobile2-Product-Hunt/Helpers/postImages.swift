//
//  postImages.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/8/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation
import UIKit

/*Code from Stack Overflow. Link: https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
 */

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
