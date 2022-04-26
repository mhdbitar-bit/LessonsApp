//
//  LessonsListViewController.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import UIKit
import Combine
import SwiftUI

final class LessonsListViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Lessons"
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
        
        view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
        
        tableView.register(LessonTableViewCell.self, forCellReuseIdentifier: LessonTableViewCell.identifier)
    }
}

extension LessonsListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
