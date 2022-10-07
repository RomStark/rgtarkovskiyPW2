//
//  NoteCell.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 07.10.2022.
//

import UIKit

class NoteCell: UITableViewCell {
    
    static let reuseIdentifier = "NoteCell"
    
    private var textView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
        
    }
    
    private func setupView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .systemBackground
        textView.setHeight(to: 140)
        textView.isEditable = true
        
        contentView.addSubview(textView)
        textView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom:16])
        contentView.backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(_ note: ShortNote) {
        textView.text = note.text
        textView.isEditable = false
    }

}
