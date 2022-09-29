//
//  ColorPalette.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 28.09.2022.
//

import UIKit

final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6
    
    init(){
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let redControl = ColorSladerView(colorName: "R", value: Float(chosenColor.cgColor.components?[0] ?? 0))
        let greenControl = ColorSladerView(colorName: "G", value: Float(chosenColor.cgColor.components?[1] ?? 0))
        let blueControl = ColorSladerView(colorName: "B", value: Float(chosenColor.cgColor.components?[2] ?? 0))
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        [redControl, greenControl, blueControl].forEach {  $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pin(to: self)

    }
    
    @objc
    private func sliderMoved(slider: ColorSladerView) {
        switch slider.tag {
        case 0:
            self.chosenColor = UIColor (
                red: CGFloat(slider.value),
                green: chosenColor.cgColor.components?[1] ?? 0,
                blue: chosenColor.cgColor.components?[2] ?? 0,
                alpha: 1
            )
        case 1:
            self.chosenColor = UIColor (
                red: chosenColor.cgColor.components?[0] ?? 0,
                green: CGFloat(slider.value),
                blue: chosenColor.cgColor.components?[2] ?? 0,
                alpha: 1
            )
        default:
            self.chosenColor = UIColor (
                red: chosenColor.cgColor.components?[0] ?? 0,
                green: chosenColor.cgColor.components?[1] ?? 0,
                blue: CGFloat(slider.value),
                alpha: 1
            )
            
        }
        sendActions(for: .touchDragInside)
    }
}

extension ColorPaletteView {
    private final class ColorSladerView: UIControl {
        private let slider = UISlider()
        private let colorLabel = UILabel()
        private(set) var value: Float
        
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            slider.value = value
            colorLabel.text = colorName
            setupView()
            slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .touchDragInside)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupView() {
            
            let stackView = UIStackView(arrangedSubviews: [
                colorLabel, slider
            ])
            stackView.axis = .horizontal
            stackView.spacing = 8
            addSubview(stackView)
            stackView.pin(to: self, [.left: 12, .top: 12, .right: 12, .bottom: 12])
        }
        
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
    
}
