//
//  DataViewCell.swift
//  PryanikiTestTask
//
//  Created by Геннадий Махмудов on 04.02.2021.
//

import UIKit

class DataViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = "Not found"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let pictureView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(pictureView)
        configureTitleConstraints()
        configurePictureConstraints()
    }
    private func configureTitleConstraints(){
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    private func configurePictureConstraints(){
        pictureView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pictureView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pictureView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
