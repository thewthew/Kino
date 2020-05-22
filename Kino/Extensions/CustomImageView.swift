//
//  CustomImageView.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit
import Lottie

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {

    var imageUrlString: String?
    var anim: AnimationView?

    func removeAnimation() {
        let animationViews = subviews.filter { $0 is AnimationView }
        animationViews.forEach { $0.removeFromSuperview() }
    }

    func addAnimation() {
        anim = AnimationView(name: "skeleton-loading")
        guard let anim = anim else {
            removeAnimation()
            return
        }
        anim.contentMode = .scaleAspectFit
        anim.play()
        anim.loopMode = .loop

        addSubview(anim)

        anim.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                anim.centerXAnchor.constraint(equalTo: centerXAnchor),
                anim.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
        anim.center = center
    }

    func loadImage(with urlString: String?) {
        guard let urlString = urlString else {
            image = UIImage(named: "default-movie")
            return
        }

        imageUrlString = urlString
        image = nil
        addAnimation()

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            removeAnimation()
            image = imageFromCache
            return
        }

        guard let imageUrlString = imageUrlString, let url = URL(string: imageUrlString) else {
            removeAnimation()
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {(data, _, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                return
            }

            guard let data = data,
                let compressedImageData = UIImage(data: data)?.jpegData(compressionQuality: 1),
                let compressedImage = UIImage(data: compressedImageData) else { return }
                if self.imageUrlString == urlString {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.removeAnimation()
                        UIView.transition(with: self,
                                          duration: 0.3,
                                          options: .transitionCrossDissolve,
                                          animations: { self.image = compressedImage },
                                          completion: nil)
                    }
                }
            imageCache.setObject(compressedImage, forKey: urlString as AnyObject)
        }).resume()
    }
}
