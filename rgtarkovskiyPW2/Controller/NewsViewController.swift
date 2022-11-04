//
//  NewsViewController.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 04.11.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavBar()
        setImageView()
        setTitleLabel()
        setDescriptionLabel()
    }
    private func setupNavBar() {
        navigationItem.title = "News"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    private func setImageView() {
//        imageView.image = UIImage(named: "")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.pin(to: view, [.left: 0, .right: 0])
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        imageView.pinHeight(to: imageView.widthAnchor, 1)
    }
    private func setTitleLabel() {
//        titleLabel.text = "Hello"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        
        view.addSubview(titleLabel)
        
        titleLabel.pinTop(to: imageView.bottomAnchor, 12)
        titleLabel.pin(to: view, [.left: 16, .right: 16])
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }
    
    private func setDescriptionLabel() {
//        descriptionLabel.text = "Hello"
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 8)
        descriptionLabel.pin(to: view, [.left: 16, .right: 16])
    }
    
    public func configure(with viewModel: NewsViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
