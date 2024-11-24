//
//  MessagesTableViewCell.swift
//  WA8_09_6279
//
//  Created by Preksha Patil on 09/11/24.
//
 
import UIKit
 
class MessagesTableViewCell: UITableViewCell {
    
    let senderNameLabel = UILabel()
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    let timestampLabel = UILabel()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var senderNameLeadingConstraint: NSLayoutConstraint!
    var senderNameTrailingConstraint: NSLayoutConstraint!
    var timestampLeadingConstraint: NSLayoutConstraint!
    var timestampTrailingConstraint: NSLayoutConstraint!
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
 
        // Configure sender name label
        senderNameLabel.font = UIFont.systemFont(ofSize: 10)
        senderNameLabel.textColor = .gray
        senderNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(senderNameLabel)
 
        // Bubble background styling
        bubbleBackgroundView.layer.cornerRadius = 16
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        // Message label styling
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        
        // Timestamp styling
        timestampLabel.font = UIFont.systemFont(ofSize: 10)
        timestampLabel.textColor = .gray
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timestampLabel)
        
        // Constraints
        let constraints = [
            // Sender name label constraints
            senderNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            // Message label constraints
            messageLabel.topAnchor.constraint(equalTo: senderNameLabel.bottomAnchor, constant: 6),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -6),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            
            timestampLabel.topAnchor.constraint(equalTo: bubbleBackgroundView.bottomAnchor, constant: 4),
            timestampLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
        
        // Leading and trailing constraints for alignment
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        // Sender name alignment constraints
        senderNameLeadingConstraint = senderNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        senderNameTrailingConstraint = senderNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        // Timestamp alignment constraints
        timestampLeadingConstraint = timestampLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        timestampTrailingConstraint = timestampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        // Initially deactivate both sets of constraints
        leadingConstraint.isActive = false
        trailingConstraint.isActive = false
        senderNameLeadingConstraint.isActive = false
        senderNameTrailingConstraint.isActive = false
        timestampLeadingConstraint.isActive = false
        timestampTrailingConstraint.isActive = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func configure(with message: Message, isCurrentUser: Bool) {
        // Set sender name label text
        senderNameLabel.text = isCurrentUser ? "You" : message.senderName
        messageLabel.text = message.text
        timestampLabel.text = formatDate(message.timestamp)
        
        if isCurrentUser {
            // Sent message style
            bubbleBackgroundView.backgroundColor = UIColor.systemBlue
            messageLabel.textColor = .white
            timestampLabel.textAlignment = .right
            senderNameLabel.textAlignment = .right
 
            // Align to the right
            leadingConstraint.isActive = false
            trailingConstraint.isActive = true
            senderNameLeadingConstraint.isActive = false
            senderNameTrailingConstraint.isActive = true
            timestampLeadingConstraint.isActive = false
            timestampTrailingConstraint.isActive = true
        } else {
            // Received message style
            bubbleBackgroundView.backgroundColor = UIColor(white: 0.9, alpha: 1)
            messageLabel.textColor = .black
            timestampLabel.textAlignment = .left
            senderNameLabel.textAlignment = .left
 
            // Align to the left
            leadingConstraint.isActive = true
            trailingConstraint.isActive = false
            senderNameLeadingConstraint.isActive = true
            senderNameTrailingConstraint.isActive = false
            timestampLeadingConstraint.isActive = true
            timestampTrailingConstraint.isActive = false
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy - hh:mm a" // e.g., "Nov 9, 2024 - 03:34 PM"
        return formatter.string(from: date)
    }
}
