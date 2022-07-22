////
////  ViewController.swift
////  Mars Rover Photos
////
////  Created by Bogdan Sevcenco on 21.07.2022.
////
//
import UIKit
//
class HomeViewController: UIViewController {
  var curiosity: RoverPhoto?
  var opportunity: RoverPhoto?
  var spirit: RoverPhoto?
    
    
    private lazy var roverTypeCV: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 370, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(RoverTypeCell.self, forCellWithReuseIdentifier: RoverTypeCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    //MARK: Variables
    var roverType = [
    "Curiosity",
    "Opportunity",
    "Spirit"
    ]
    //MARK: Functions
    func setupUI(){
        view.addSubviews(roverTypeCV)
        
        roverTypeCV.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    

  override func viewDidLoad() {
    super.viewDidLoad()
      view.backgroundColor = .white
    fetchCuriosity()
    fetchSpirit()
    fetchOpportunity()
      roverTypeCV.delegate = self
      roverTypeCV.dataSource = self
      setupUI()
  }
  private func fetchCuriosity() {
    APICaller.shared.getCuriosityRovers{ [weak self] result in
      DispatchQueue.main.async { [self] in
        switch result {
        case .success(let model):
            self?.saveImages(photos: model)
          self?.curiosity = model
          print(self?.curiosity?.photos.count)

        case .failure(let error):
          print("Parsing Error: \(error.localizedDescription)")
//          self?.failedToGetProfile()
        }
      }
    }
  }

  private func fetchSpirit() {
    APICaller.shared.getSpiritRovers{ [weak self] result in
      DispatchQueue.main.async { [self] in
        switch result {
        case .success(let model):
            self?.saveImages(photos: model)
          self?.spirit = model
          print(self?.spirit?.photos.count)

        case .failure(let error):
          print("Parsing Error: \(error.localizedDescription)")
//          self?.failedToGetProfile()
        }
      }
    }
  }
  private func fetchOpportunity() {
    APICaller.shared.getOpportunityRovers{ [weak self] result in
      DispatchQueue.main.async { [self] in
        switch result {
        case .success(let model):
            self?.saveImages(photos: model)

          self?.opportunity = model
          print(self?.opportunity?.photos.count)

        case .failure(let error):
          print("Parsing Error: \(error.localizedDescription)")
//          self?.failedToGetProfile()
        }
      }
    }
  }


}

extension HomeViewController:  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverTypeCell.identifier, for: indexPath) as? RoverTypeCell else {return UICollectionViewCell()}
        cell.setup(title: roverType[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            if let photos = curiosity {
                self.navigationController?.pushViewController(RoverPhotosViewController(photos: photos, rootOption: .curiosity), animated: true)
            }
        case 1:
            if let photos = opportunity {
                self.navigationController?.pushViewController(RoverPhotosViewController(photos: photos, rootOption: .opportunity), animated: true)
            }
        case 2:
            if let photos = spirit {
                self.navigationController?.pushViewController(RoverPhotosViewController(photos: photos,  rootOption: .spirit), animated: true)
            }
        default:
            break
        }
    }
}


extension HomeViewController {
    func ifSaved() -> Bool {
        return false
    }
    func saveImages(photos : RoverPhoto) {
        if !ifSaved() {
//            if let photos
            for i in photos.photos.prefix(100) {
                
                LocalFileManager.shared.saveImage(image: self.load(url: i.imgSrc), name: "\(i.id)")
            }
        }
    }
    
        func load(url: String) -> UIImage {
            if let url = URL(string: url) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                            return image
                    }
                }
            }
            return UIImage()
        }


}

