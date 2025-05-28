//
//  ViewController.swift
//  chatzero
//
//  Created by Hector Steven Villasano on 5/27/25.
//

import UIKit


class ViewController: UIViewController {
    let googleGen = GoogleGen()
    let storyTextView = UITextView()
    let fetchButton = UIButton(type: .system)
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white

        // Configure TextView
        storyTextView.isEditable = false
        storyTextView.font = UIFont.systemFont(ofSize: 16)
        storyTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(storyTextView)

        // Configure Button
        fetchButton.setTitle("Fetch Story", for: .normal)
        fetchButton.addTarget(self, action: #selector(fetchStoryTapped), for: .touchUpInside)
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fetchButton)

        // Configure Activity Indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        // Set up Constraints
        NSLayoutConstraint.activate([
            storyTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            storyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            storyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            storyTextView.bottomAnchor.constraint(equalTo: fetchButton.topAnchor, constant: -20),

            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func fetchStoryTapped() {
        activityIndicator.startAnimating()
        storyTextView.text = "Fetching story..."
        Task {
            await googleGen.fetchContent()
            activityIndicator.stopAnimating()
            self.storyTextView.text = googleGen.text
        }
    }

}

