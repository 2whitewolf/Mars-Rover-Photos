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
class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate {

  private let listsController: NSFetchedResultsController<Rover>

  private let dataController : DataController


  var curiosity: RoverPhoto?
  var opportunity: RoverPhoto?
  var spirit: RoverPhoto?
  private var rover: Rover


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


  private func updateCoreData(rovers: RoverPhoto, type: String) {
    let photos = rovers.photos.prefix(100)
    for i in photos {
      rover.id = Int64(i.id)
      rover.earthDate = i.earthDate
      let image = load(url:i.imgSrc)
      guard let data = image.jpegData(compressionQuality: 0.8) else { return }
      rover.image = data
      rover.roverType = type
      dataController.save()
    }
  }

  init(dataController: DataController) {
    self.dataController = dataController
    let newRover = Rover(context: dataController.container.viewContext)
    rover = newRover
    let request: NSFetchRequest<Rover> = Rover.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Rover.id, ascending: false)]

    listsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)

    super.init(nibName: nil, bundle: nil)

    listsController.delegate = self
    do {

      try listsController.performFetch()

    } catch {
      print("Error")

      //          presentFacesAlertOnMainThread(title: Strings.generalError, message: FacesError.unableToFetchFaces.rawValue, buttonTitle: Strings.ok)

    }

  }

  required init?(coder: NSCoder) {

    fatalError("init(coder:) has not been implemented")

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
          self?.curiosity = model
          self?.updateCoreData(rovers: model, type: "Curiosity")
          print("Count \(model.photos.count)")

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
          self?.spirit = model

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
          self?.opportunity = model
          print(model.photos.count)

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
//  func ifSaved() -> Bool {
//    return false
//  }
//  func saveImages(photos : RoverPhoto) {
//    if !ifSaved() {
//      //            if let photos
//      for i in photos.photos.prefix(100) {
//
//        LocalFileManager.shared.saveImage(image: self.load(url: i.imgSrc), name: "\(i.id)")
//      }
//    }
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

