//
//  NewsViewCell.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 01.11.2022.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsViewCell"
    private let newsImageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "")
        image.layer.cornerRadius = 8
        image.layer.cornerCurve = .continuous
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .secondarySystemBackground
        return image
    }()
    
    private let newsTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "World"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let newsDescriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Hello"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupImageView() {
        contentView.addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        newsImageView.pinWidth(to: newsImageView.heightAnchor)
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.heightAnchor.constraint(equalToConstant: newsTitleLabel.font.lineHeight).isActive = true
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 12).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true

    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(newsDescriptionLabel)
        
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 12).isActive = true
        newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 12).isActive = true
        newsDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        newsDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        
    }
    
    public func configure(_ viewModel: NewsViewModel ) {
        newsTitleLabel.text = viewModel.title
        newsDescriptionLabel.text = viewModel.description
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}
