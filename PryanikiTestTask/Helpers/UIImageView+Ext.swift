//
//  UIImageView+Ext.swift
//  PryanikiTestTask
//
//  Created by Геннадий Махмудов on 03.02.2021.
//

import UIKit
import Alamofire

extension UIImageView {
    public final func setImage(with url: String){
        AF.request(url).responseData { [weak self] loadedData in
            let image = UIImage(data: loadedData.data ?? Data())
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
