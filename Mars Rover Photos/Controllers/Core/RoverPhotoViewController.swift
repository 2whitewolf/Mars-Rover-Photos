//
//  CuriosityViewController.swift
//  Mars Rover Photos
//
//  Created by Bogdan Sevcenco on 21.07.2022.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage
class RoverPhotosViewController: UIViewController {
    
    
  var roverPhoto: [Rover]?



  private var collectionView: UICollectionView = {
    var collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    collectionViewLayout.itemSize = .init(width: 120 , height: 120)
    collectionViewLayout.minimumLineSpacing = 20
    collectionViewLayout.minimumInteritemSpacing = 0
    var collection = UICollectionView(frame: .zero,collectionViewLayout: collectionViewLayout)
      collection.backgroundColor = .clear
    collection.isScrollEnabled = true
    collection.showsVerticalScrollIndicator = false
    collection.register(TestCell.self, forCellWithReuseIdentifier: TestCell.identifier)
    return collection
  }()
    
    convenience init(photos: [Rover],rootOption option: ScreenType){
        self.init()
        self.roverPhoto = photos
        self.collectionView.reloadData()
        title = "\(option.roverType)"
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
   
 
    
      view.addSubviews(collectionView)
      collectionView.snp.makeConstraints{
        $0.leading.trailing.bottom.top.equalToSuperview()
      }
      
      self.collectionView.dataSource = self
      self.collectionView.delegate = self

  }


}


extension RoverPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if let curiosity = roverPhoto?.count {
            return curiosity
        }
      return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCell.identifier, for: indexPath) as? TestCell else {
            return UICollectionViewCell()
        }
        
      if let curiosity = roverPhoto?[indexPath.row]{
          cell.setup(with: RoverViewModel(roverId: Int(curiosity.id), roverImg: curiosity.image ?? "", roverDate: curiosity.earthDate ?? ""))
        }
    return cell
    }


}
