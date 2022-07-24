////
////  ViewController.swift
////  Mars Rover Photos
////
////  Created by Bogdan Sevcenco on 21.07.2022.
////
//
import UIKit
import CoreData
//
class HomeViewController: UIViewController{

//  private let listsController: NSFetchedResultsController<Rover>
//
//  private let dataController : DataController


  var curiosity: [Rover]?
  var opportunity: [Rover]?
  var spirit: [Rover]?
  static var photos = [Rover]()
//  private var rover: Rover


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
    HomeViewController.photos = CoreDataManager.shared.fetchRovers()
    print(HomeViewController.photos.count)
    curiosity = HomeViewController.photos.filter{$0.roverType == "Curiosity" }
    opportunity = HomeViewController.photos.filter{ $0.roverType == "Opportunity"}
    spirit = HomeViewController.photos.filter{$0.roverType == "Spirit"}

    roverTypeCV.delegate = self
    roverTypeCV.dataSource = self
    setupUI()
  }


  private func updateCoreData(photos: RoverPhoto, type: String) {
    let rover = photos.photos.prefix(100)
    for i in rover {
      let newRover = CoreDataManager.shared.createNote()

      newRover.roverType = type
      newRover.id = Int64(i.id)
      newRover.earthDate = i.earthDate
      newRover.image = i.imgSrc
      CoreDataManager.shared.save()
    }
  }
  private func fetchCuriosity() {
    APICaller.shared.getCuriosityRovers{ [weak self] result in
      DispatchQueue.main.async { [self] in
        switch result {
        case .success(let model):
//          self?.curiosity = model




          self?.updateCoreData(photos: model, type: "Curiosity")

          CoreDataManager.shared.save()

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

          self?.updateCoreData(photos: model, type: "Spirit")

          CoreDataManager.shared.save()

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
          self?.updateCoreData(photos: model, type: "Opportunity")

          CoreDataManager.shared.save()
//          print(model.photos.count)

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
//  func fetchNotesFromStorage() {
//      HomeViewController.photos = CoreDataManager.shared.fetchNotes()
//  }

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

