//
//  ResultPageViewController.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/25.
//

import UIKit

protocol ResultPageViewControllerStore {

    func save(photoModel: PhotoModel)
    func delete(photoModel: PhotoModel)
}

class ResultPageViewController: UIViewController {
    
    private let viewModel = ResultPageViewModel()
    private let store: ResultPageViewControllerStore?
    
    var keyWord = ""
    var imagePerPage = ""
    
    let cellWidth = (UIScreen.main.bounds.width / CGFloat(2.0))
    let cellHeight = (UIScreen.main.bounds.width / CGFloat(2.0)) * 1.2
    let collectionViewCellID = "CollectionViewCell"

    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: collectionViewCellID)
        
        collectionView.backgroundColor = .white
        
        return collectionView
    } ()
    
    init(store: ResultPageViewControllerStore?) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupCollectionView()
        fetchData()
    }
    
}

extension ResultPageViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func fetchData() {
        viewModel.loadContent(keyword: keyWord, imagePerPage: imagePerPage, currentPage: 1)
    }
}

extension ResultPageViewController: ResultPageViewModelDelegate {
    func viewModel(_ viewModel: ResultPageViewModel, didUpdateAlbumPageData data: [PhotoModel]) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func viewModel(_ viewModel: ResultPageViewModel, didUpdateFavorites favorites: [PhotoModel]) {
        
    }
    
    func viewModel(_ viewModel: ResultPageViewModel, didReceiveError error: Error) {
        
    }
    
    
}



extension ResultPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellInfo = viewModel.photoModels[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellID, for: indexPath) as? PhotoCell else {
            
            return collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellID, for: indexPath)
        }
        
        if let imageURL: URL = URL(string: cellInfo.imageURL) {
            cell.imageView.loadImage(at: imageURL)
        }
        
        cell.layout(with: cellInfo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.photoModels.count - 2) &&
            (viewModel.currentPage + 1) <= viewModel.totalPages {
            
            viewModel.loadContent(keyword: keyWord, imagePerPage: imagePerPage, currentPage: viewModel.currentPage + 1)
            print("自動載入下一頁")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cellInfo = viewModel.photoModels[indexPath.item]
        
        cellInfo.isFavorite = !cellInfo.isFavorite
        
        if cellInfo.isFavorite {
            //Do add to DB
            store?.save(photoModel: cellInfo)
        } else {
            //Do remove to DB
            store?.delete(photoModel: cellInfo)
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
    
}

extension ResultPageViewController: UICollectionViewDelegate {
    
}

extension ResultPageViewController: UICollectionViewDelegateFlowLayout {
    
}

extension PhotoModel: PhotoCellSpec {
    
    var labelText: String {
        return title
    }
}
