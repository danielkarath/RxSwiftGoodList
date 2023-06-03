//
//  TaskListTableViewCell.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {

    static let cellidentifier: String = "TaskListTableViewCell"
    
    private let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = CustomConstants.basicFontColor
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.font = CustomConstants.setFont(fontSize: 14, isBold: false)
        label.isAccessibilityElement = true
        return label
    }()
    
    private let priorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = CustomConstants.secondaryFontColor
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.font = CustomConstants.setFont(fontSize: 8, isBold: true)
        label.isAccessibilityElement = true
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupView()
         setupConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("IDQPlayView is unsupported!")
     }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.cornerRadius = 14
        taskTitleLabel.text = nil
    }
    
    //MARK: - Private
    
    private func setupView() {
        layer.cornerRadius = 16
        //backgroundColor = IDQConstants.contentBackgroundColor
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        addSubviews(taskTitleLabel, priorityLabel)
        NSLayoutConstraint.activate([
            taskTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            taskTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            taskTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            taskTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            priorityLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: -4),
            priorityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            priorityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            priorityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
        ])
    }
    
    
    //MARK: - Public
    
    public func configure(with task: Task) {
        guard !task.title.isEmpty else { return }
        taskTitleLabel.text = task.title
        var priorityText: String?
        switch task.priority {
        case .low:
            priorityText = "low"
        case .normal:
            priorityText = "normal"
        case .high:
            priorityText = "high"
        default:
            priorityText = "normal"
        }
        priorityLabel.text = priorityText!
    }

}
