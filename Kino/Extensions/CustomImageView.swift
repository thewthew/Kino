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
        animationViews.forEach { (view) in
            view.removeFromSuperview()
        }
    }

    func addAnimation() {
        anim = AnimationView(name: "skeleton-loading")
        guard let anim = anim else {
            removeAnimation()
            return
        }
        anim.contentMode = .scaleAspectFit
        addSubview(anim)

        anim.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                anim.centerXAnchor.constraint(equalTo: centerXAnchor),
                anim.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
        anim.center = center
        anim.play()
        anim.loopMode = .loop
    }

    func loadImageUsingUrl(urlString: String) {
        imageUrlString = urlString
        image = nil
        addAnimation()

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            removeAnimation()
            image = imageFromCache
            return
        }

        if let imageUrlString = imageUrlString, let url = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: url, completionHandler: {(data, _, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    return
                }

                DispatchQueue.main.async { [weak self] in
                    guard let data = data, let self = self else {
                        return
                    }
                    let imageToCache = UIImage(data: data)
                    if self.imageUrlString == urlString {
                        self.removeAnimation()
                        UIView.transition(with: self,
                                          duration: 0.3,
                                          options: .transitionCrossDissolve,
                                          animations: { self.image = imageToCache },
                                          completion: nil)
                    }
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                }
            }).resume()
        }
    }
}
