//
//  LessonsListViewController.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import UIKit
import Combine
import SwiftUI

final class LessonsListViewController: UITableViewController, Alertable {
    
    private var service: LessonService?
    private var lessons = [Lesson]()
    
    convenience init(service: LessonService) {
        self.init()
        self.service = service
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Lessons"
        view.backgroundColor = .backgroundColor
        setupNavigation()
        setupTableView()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .backgroundColor
        tableView.register(LessonTableViewCell.self, forCellReuseIdentifier: LessonTableViewCell.identifier)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        refreshControl?.beginRefreshing()
        service?.getLessons(completion: { [weak self] result in
            guard let self = self else { return }
            self.refreshControl?.endRefreshing()
            switch result {
            case .success(let lessons):
                self.lessons = lessons
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        })
    }
}

extension LessonsListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonTableViewCell.identifier, for: indexPath)
        let image = UIImage(systemName: "chevron.forward")
        let disclosureIndicator = UIImageView(frame:CGRect(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0))
        disclosureIndicator.image = image
        cell.accessoryView = disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIHostingController(rootView: LessonDetailView())
        
        show(vc, sender: self)
    }
}
