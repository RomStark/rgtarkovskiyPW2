//
//  AddNoteCell.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 06.10.2022.
//

import UIKit

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNote)
}

class AddNoteCell: UITableViewCell {

    static let reuseIdentifier = "AddNoteCell"
    
    private var textView = UITextView()
    
    private var addButton = UIButton()
    
    var delegate: AddNoteDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    private func setupView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .systemBackground
        textView.setHeight(to: 140)
        textView.isEditable = true
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.alpha = 0.5
        addButton.isHidden = false
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom:16])
        contentView.backgroundColor = .systemGray5
    }
    
    @objc
    func addButtonTapped(_ sender: UIButton) {
        updateUI()
        delegate?.newNoteAdded(note: ShortNote(text: textView.text))
        clearTextView()
    }
    
    private func updateUI() {
        
    }
    
    private func clearTextView() {
        textView.text = ""
    }

}
