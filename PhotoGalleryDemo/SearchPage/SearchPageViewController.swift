//
//  SearchPageViewController.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/22.
//

import UIKit

class SearchPageViewController: UIViewController {

    private let viewModel = SearchPageViewModel()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 80, width: 200.0, height: 34.0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.placeholder = "搜尋內容"
    
        return textField
    }()
    
    lazy var imagePerPageTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 120, width: 200.0, height: 34.0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.placeholder = "每頁圖片數"
    
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.frame = CGRect(x: 10, y: 160, width: 200.0, height: 34.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("搜尋圖片", for: .normal)
        button.addTarget(self, action: #selector(checkInputContentIsValid(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initializeViewModel()
        setupViews()
        
        NSLayoutConstraint.activate([
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            searchTextField.widthAnchor.constraint(equalToConstant: 200),
            searchTextField.heightAnchor.constraint(equalToConstant: 34),
            imagePerPageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePerPageTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            imagePerPageTextField.widthAnchor.constraint(equalToConstant: 200),
            imagePerPageTextField.heightAnchor.constraint(equalToConstant: 34),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 120),
            searchButton.heightAnchor.constraint(equalToConstant: 34),
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeViewModel()
        searchButton.frame = CGRect(x: 10, y: 160, width: 200.0, height: 34.0)
    }
    
    private func setupViews() {
        view.addSubview(searchTextField)
        view.addSubview(imagePerPageTextField)
        view.addSubview(searchButton)
        
        
    }

    private func pushResultVC() {
        let resultVC = ResultPageViewController()
        resultVC.keyWord = viewModel.searchKeyWord
        resultVC.imagePerPage = viewModel.photosPerPage
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    @objc
    private func checkInputContentIsValid(_ sender: UIButton) {
        guard let searchTextContent = searchTextField.text else { return /*TODO: 警告訊息 */}
        guard let perPageContent = imagePerPageTextField.text,
            let perPageNumber = Int(perPageContent) ?? 0,
            perPageNumber > 0 else { return /*TODO: 警告訊息 */}
        
        viewModel.setViewModelContent(searchTextContent, perPageContent)
        pushResultVC()
    }
    
    private func initializeViewModel() {
        viewModel.initializeViewModel()
    }
}

