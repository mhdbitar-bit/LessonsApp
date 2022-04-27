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
    
    private var viewModel: LessonListViewModel!
    private var lessons = [Lesson]()
    private var cancellables: Set<AnyCancellable> = []
    
    convenience init(viewModel: LessonListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Lessons"
        view.backgroundColor = .backgroundColor
        setupNavigation()
        setupTableView()
        setupRefreshControl()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView.numberOfRows(inSection: 0) == 0 {
            refresh()
        }
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
    
    private func bind() {
        bindLoading()
        bindError()
        bindLessons()
    }
    
    private func bindLoading() {
        viewModel.$isLoading.sink { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.refreshControl?.beginRefreshing()
                } else {
                    self.refreshControl?.endRefreshing()
                }
            }
        }.store(in: &cancellables)
    }
    
    private func bindError() {
        viewModel.$error.sink { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(message: error)
            }
        }.store(in: &cancellables)
    }
    
    private func bindLessons() {
        viewModel.$lessons.sink { [weak self] lessons in
            guard let self = self else { return }
            self.lessons = lessons
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    @objc private func refresh() {
        viewModel.loadLessons()
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
        let lesson = lessons[indexPath.row]
        let cell = LessonTableViewCell()
        let image = UIImage(systemName: "chevron.forward")
        let disclosureIndicator = UIImageView(frame:CGRect(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0))
        disclosureIndicator.image = image
        cell.accessoryView = disclosureIndicator
        cell.configure(with: lesson, imageService: viewModel.imageDataService)
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
