////
////  ViewController.swift
////  Mars Rover Photos
////
////  Created by Bogdan Sevcenco on 21.07.2022.
////
//
//import UIKit
//
//class HomeViewController: UIViewController {
//  var curiosity: RoverPhoto?
//  var opportunity: RoverPhoto?
//  var spirit: RoverPhoto?
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    fetchCuriosity()
//    fetchSpirit()
//    fetchOpportunity()
//
//    // Do any additional setup after loading the view.
//  }
//  private func fetchCuriosity() {
//    APICaller.shared.getCuriosityRovers{ [weak self] result in
//      DispatchQueue.main.async { [self] in
//        switch result {
//        case .success(let model):
//
//          self?.curiosity = model
//          print(self?.curiosity?.photos.count)
//
//        case .failure(let error):
//          print("Parsing Error: \(error.localizedDescription)")
////          self?.failedToGetProfile()
//        }
//      }
//    }
//  }
//
//  private func fetchSpirit() {
//    APICaller.shared.getSpiritRovers{ [weak self] result in
//      DispatchQueue.main.async { [self] in
//        switch result {
//        case .success(let model):
//
//          self?.spirit = model
//          print(self?.spirit?.photos.count)
//
//        case .failure(let error):
//          print("Parsing Error: \(error.localizedDescription)")
////          self?.failedToGetProfile()
//        }
//      }
//    }
//  }
//  private func fetchOpportunity() {
//    APICaller.shared.getOpportunityRovers{ [weak self] result in
//      DispatchQueue.main.async { [self] in
//        switch result {
//        case .success(let model):
//
//          self?.opportunity = model
//          print(self?.opportunity?.photos.count)
//
//        case .failure(let error):
//          print("Parsing Error: \(error.localizedDescription)")
////          self?.failedToGetProfile()
//        }
//      }
//    }
//  }
//
//
//}
//
