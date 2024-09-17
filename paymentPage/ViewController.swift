//
//  ViewController.swift
//  paymentPage
//
//  Created by Рамазан Абайдулла on 29.05.2024.
//

import UIKit
enum PayVariant: Int, CaseIterable {
    case small = 100
    case middle = 300
    case big = 500
}

class ViewController: UIViewController {
    
    private lazy var textStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img1")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: view.frame.width/1.5).isActive = true
        image.widthAnchor.constraint(equalToConstant: view.frame.width/1.5).isActive = true
        
        return image
    }()
    
    private lazy var payBtn: UIButton = {
        let btn = UIButton(primaryAction: payBtnAction)
        btn.setTitle("поддержать", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(named: "Dark green")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 51).isActive = true
    
        return btn
    }()
    
    private lazy var payBtnAction = UIAction { _ in
        print(self.selectPrice)
    }
    
    private var selectPrice = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Main")
        setCircle()
        setImage()
        setText()
        setVariants()
        setBtn()
    }
    
    private func setCircle() {
        let circle1 = makeCircle(frame: CGRect(x: view.frame.width - 74, y: -28, width: 100, height: 100))
        let circle2 = makeCircle(frame: CGRect(x: 83, y: 100, width: 67, height: 67))
        let circle3 = makeCircle(frame: CGRect(x: view.frame.width - 202, y: 216, width: 286, height: 286))
        let circle4 = makeCircle(frame: CGRect(x: 83, y: view.frame.height - 272, width: 56, height: 56))
        let circle5 = makeCircle(frame: CGRect(x: view.frame.width - 121, y: view.frame.height - 120, width: 97, height: 97))
        
        [circle1, circle2, circle3, circle4, circle5].forEach { item in
            view.addSubview(item)
        }
    }
    
    private func setImage() {
        view.addSubview(image)
        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setText() {
        view.addSubview(textStack)
        
        let pageTitle = createLabel(size: 30, weight: .bold, text: "Приложение и все его функции бесплатные")
        let pageSubtitle = createLabel(size: 16, weight: .regular, text: "все средства идут на улучшение и поддержку проекта")
        
        textStack.addArrangedSubview(pageTitle)
        textStack.addArrangedSubview(pageSubtitle)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setVariants() {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 0
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hStack)
        
        PayVariant.allCases.forEach { variant in hStack.addArrangedSubview(createPayVariant(variant: variant))
        }
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 60),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setBtn() {
        view.addSubview(payBtn)
        
        NSLayoutConstraint.activate([
            payBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            payBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            payBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func selectVariant(sender: UIGestureRecognizer) {
        PayVariant.allCases.forEach { variant in
            if let sView = self.view.viewWithTag(variant.rawValue) {
                sView.layer.borderWidth = 0
                sView.layer.borderColor = .none
            }
            
            if let selectTag = sender.view?.tag {
                if let selectedTag = sender.view?.viewWithTag(selectTag) {
                    selectedTag.layer.borderColor = UIColor.white.cgColor
                    selectedTag.layer.borderWidth = 2
                    self.selectPrice = selectTag
                }
                    
            }
        }
    }
    
//    MARK: Create view
    
    private func createPayVariant(variant: PayVariant) -> UIView {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVariant(sender: )))
        
        let payView = UIView()
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        payView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        payView.layer.cornerRadius = 20
        payView.tag = variant.rawValue
        payView.addGestureRecognizer(tapGesture)
        
        switch variant {
        case .small:
            payView.backgroundColor = UIColor(named: "Orange")
            payView.layer.borderWidth = 2
            payView.layer.borderColor = UIColor.white.cgColor
        case .middle:
            payView.backgroundColor = UIColor(named: "Pink")
        case .big:
            payView.backgroundColor = UIColor(named: "Dark green")
        }
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        let sumLabel = createLabel(size: 31, weight: .bold, text: "\(variant.rawValue)")
        let sumDescription = createLabel(size: 16, weight: .light, text: "рублей")
        
        vStack.addArrangedSubview(sumLabel)
        vStack.addArrangedSubview(sumDescription)
        
        payView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: payView.topAnchor, constant: 23),
            vStack.bottomAnchor.constraint(equalTo: payView.bottomAnchor, constant: -23),
            vStack.leadingAnchor.constraint(equalTo: payView.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalToSystemSpacingAfter: payView.trailingAnchor, multiplier: -10)
        ])
        
        return payView
    }
    
    private func makeCircle(frame: CGRect) -> UIView {
        let circle = UIView()
        circle.backgroundColor = UIColor(named: "Circle")
        circle.frame = frame
        circle.layer.cornerRadius = frame.width/2
        circle.layer.masksToBounds = true
        return circle
    }
    
    private func createLabel(size: CGFloat, weight: UIFont.Weight, text: String) -> UILabel {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        
        return label
    }


}

