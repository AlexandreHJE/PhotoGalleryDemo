//
//  PhotoCell.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/25.
//

import UIKit

protocol PhotoCellSpec {
    var labelText: String { get }
    var isFavorite: Bool { get }
}

class PhotoCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heart_off")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(favoriteIcon)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 34.0),
            favoriteIcon.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5.0),
            favoriteIcon.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5.0),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 32.0),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 32.0),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.cancelImageLoad()
      }
    
    func layout(with spec: PhotoCellSpec) {
        titleLabel.text = spec.labelText
        favoriteIcon.image = spec.isFavorite ? UIImage(named: "heart_on") : UIImage(named: "heart_off")
    }
}
