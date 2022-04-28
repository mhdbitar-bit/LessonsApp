//
//  LessonTableViewCell.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import UIKit

final class LessonTableViewCell: UITableViewCell {
    static let identifier = "LessonTableViewCell"
    
    let lessonImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "test"))
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let lessonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var imageData: Data?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(lessonImage)
        contentView.addSubview(lessonNameLabel)
        backgroundColor = .clear
        selectionStyle = .none
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
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
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
    
    func configure(with lesson: Lesson, imageService: LessonImageDataService) {
        self.lessonNameLabel.text = lesson.name
        imageService.loadImageData(from: lesson.thumbnail) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.lessonImage.image = UIImage(data: data)
                }
            case .failure:
                // TODO Add retry button
                break
            }
        }
    }
}
