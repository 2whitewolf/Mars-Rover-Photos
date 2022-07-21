//
//  TestCell.swift
//  NasaTest
//
//  Created by Dumitru Rahmaniuc on 21.07.2022.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

final class TestCell: UICollectionViewCell {
    
    static let identifier = "TestCell"
    
    //MARK: -UIElements
    private lazy var testImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    
    
    //MARK: -Variables
    
    
    //MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions
    
    
    private func setupLayout() {
      backgroundColor = .gray
        
        addSubviews(testImage  )
        
        testImage.snp.makeConstraints{
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
        
    }
    
    public func setup(with model: String){
      guard let urlString = URL(string: model) else {return}
        testImage.sd_setImage(with: urlString, completed: nil)
      
       print(urlString)
    }
    
}

extension UIView{

    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0)}
    }
}

















