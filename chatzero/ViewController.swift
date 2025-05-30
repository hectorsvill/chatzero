//
//  ViewController.swift
//  chatzero
//
//  Created by Hector Steven Villasano on 5/27/25.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let googleGen = GoogleGen()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let tableview = UITableView()
    let chatMessages = ["Chat with gemini"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = chatMessages[indexPath.row]
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selcted row: \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

    func setupUI() {
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        // Configure table view
        title = "ChatZero"
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        // disable autoresizing mask tranlation to us constrainst
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Activity Indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        // Set up Constraints
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func fetchStoryTapped() {
        activityIndicator.startAnimating()
        Task {
            await googleGen.fetchContent()
            activityIndicator.stopAnimating()
//            self.storyTextView.text = googleGen.text
        }
    }

}

