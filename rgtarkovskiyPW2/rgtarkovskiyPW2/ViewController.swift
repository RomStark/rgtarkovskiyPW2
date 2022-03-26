//
//  ViewController.swift
//  rgtarkovskiyPW2
//
//  Created by Al Stark on 21.09.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
     public let settingsView = UIView()
     let locationToggle = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupLocationTextView()
        //setupSettingsView()
        setupSettingsView()
        setupSettingsButton()
        //setupLocationToggle()
        //setupLocationManager()
        
        
        
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
    }
    
    private func setupSettingsButton(){
        
        let settingsButton = UIButton()
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),  for: .touchUpInside)
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        
        settingsButton.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -15 ).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive
        = true
        settingsButton.widthAnchor.constraint(equalTo:
        settingsButton.heightAnchor).isActive = true
        
        
    }
    
    
    
    
   
    
    let SecondView = SettingsViewController();
    @objc private func settingsButtonPressed() {
        SecondView.SecondScreen = view
        SecondView.locationTextView = locationTextView
        present(SecondView, animated: true)
        
    }
    
    public func setupSettingsView(){
        view.addSubview(settingsView)
        settingsView.alpha = 0
        settingsView.backgroundColor = .orange
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 60
        ).isActive = true
        
        settingsView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -10 ).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive
        = true
        settingsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    
    public let locationTextView = UITextView()
    
    private func setupLocationTextView() {
        view.addSubview(locationTextView)
        locationTextView.backgroundColor = .white
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        locationTextView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 60
        ).isActive = true
        locationTextView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        locationTextView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
        ).isActive = true
        locationTextView.isUserInteractionEnabled = false
    }
    
    
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D =  manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}

