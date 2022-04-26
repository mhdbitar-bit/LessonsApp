//
//  LessonsListViewController.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import UIKit
import Combine

final class LessonsListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//        cell.lesson =
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

final class LessonTableViewCell: UITableViewCell {
    static let identifier = "LessonTableViewCell"
    
    private let lessonImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "test"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let lessonNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Key To Success In iPhone Photography"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(lessonImage)
        contentView.addSubview(lessonNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lessonImage.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: nil,
            paddingTop: 5,
            paddingLeft: 5,
            paddingBottom: 5,
            paddingRight: 0,
            width: 90,
            height: 0
        )
        
        lessonNameLabel.anchor(
            top: topAnchor,
            left: lessonImage.rightAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 5,
            paddingLeft: 10,
            paddingBottom: 0,
            paddingRight: 0,
            width: frame.size.width,
            height: 0
        )
    }
}
