//
//  NewsListViewController.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 01.11.2022.
//

import UIKit

final class NewsListViewController: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var isLoading = false
    private var newsViewModels = [NewsViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchNews()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(refreshData))
        configureTableView()
    }
    @objc
    private func refreshData() {
        fetchNews()
    }
    
    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }
    private func setTableViewUI() {
        self.view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 120
        tableView.pinLeft(to: view)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinRight(to: view)
        tableView.pinBottom(to: view)
        
        
    }
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func setTableViewCell() {
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: NewsViewCell.reuseIdentifier)
    }
    
    @objc
    private func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func fetchNews() {
        ApiService.shared.getTopStories{ [weak self] result in
            switch result {
            case .success(let articles):
                self!.newsViewModels = articles.compactMap {
                    NewsViewModel(
                        title: $0.title,
                        description: $0.articleDescription ?? "No description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                }
                DispatchQueue.main.async {
                    self!.isLoading = false
                    self!.tableView.reloadData()
                }
            case .failure(let error) :
                print(error)
            }
        }
    }
    
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 0
        } else {
            return newsViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            
        } else {
            let viewModel = newsViewModels[indexPath.row]
            if let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.reuseIdentifier, for: indexPath) as? NewsViewCell {
                newsCell.configure(viewModel)
                return newsCell
            }
            
        }
        return UITableViewCell()
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading {
            let newsVC = NewsViewController()
            newsVC.configure(with: newsViewModels[indexPath.row])
            navigationController?.pushViewController(newsVC, animated: true)
        }
    }
}
