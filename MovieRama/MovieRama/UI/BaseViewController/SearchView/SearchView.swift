//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit
import Combine

class SearchView: UIView {
    
    private var cancellable = Cancellable()
    
    // MARK: SearchField Publisher
    var searchFieldValue: AnyPublisher<String?, Never> {
        return searchFieldValueSubject.eraseToAnyPublisher()
    }
    private var searchFieldValueSubject = PassthroughSubject<String?, Never>()
    
    // MARK: UI Properties
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.addCornerRadius(6)
        return view
    }()
    
    private(set) lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextAttributes = String.textAttributes(font: .semiBold, size: 18, color: .appGray)
        textField.tintColor = .gray
        
        textField.delegate = self
        return textField
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cleanTextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete_text_icon"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Movie, TV Shows".style(font: .semiBold, size: 15, color: .gray.withAlphaComponent(0.5))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(wrapperView)
        wrapperView.addSubview(searchTextField)
        
        wrapperView.addSubview(placeholderLabel)
        wrapperView.addSubview(cleanTextButton)
        addSubview(searchImageView)
    }
    
    private func setupLayout() {
        
        wrapperView.layout(
            .top(0),
            .leading(28),
            .trailing(50),
            .bottom(0)
        )
        
        // searchTextField.backgroundColor = .red
        searchTextField.layout(
            .top(5),
            .leading(7),
            .trailing(24),
            .bottom(5)
        )
        
        placeholderLabel.layout(
            .top(5),
            .leading(9),
            .trailing(24),
            .bottom(5)
        )
        
        cleanTextButton.layout(
            .trailing(10),
            .centerY(0)
        )
        
        searchImageView.layout(
            .leading(15, .to(wrapperView, .trailing)),
            .centerY(0)
        )
    }
    
    func bindUI() {
        
        cleanTextButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.cleanTextField()
            }
            .store(in: &cancellable)
        
        searchTextField
            .publisher
            //.map { String($0) }
            .sink { [weak self] text in
                guard let self = self else { return }
                self.textFieldDidChange(with: text)
            }
            .store(in: &cancellable)
    }
    
    func textFieldDidChange(with text: String) {
        // Trimming the blank spaces
        let text = text.trimmingCharacters(in: .whitespaces)
        searchFieldValueSubject.send(text)
        updateTextFieldUI()
    }
    
    func cleanTextField() {
        searchTextField.text = ""
        searchFieldValueSubject.send(nil)
        updateTextFieldUI()
    }
    
    private func updateTextFieldUI() {
        let text = searchTextField.text ?? ""
        cleanTextButton.isHidden = text.count < 1
        placeholderLabel.isHidden = text.count > 0
    }
}

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
