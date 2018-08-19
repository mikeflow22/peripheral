//
//  ViewController.swift
//  peripheral advert app
//
//  Created by Michael Flowers on 7/26/18.
//  Copyright © 2018 Michael Flowers. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController ,  UITextFieldDelegate , CBPeripheralManagerDelegate {

    //MARK: IBOutlets
    @IBOutlet weak var myTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        AdvertizeController.shared.myPeri = CBPeripheralManager(delegate: self, queue: nil)
        myTextField.delegate = self
        
    }

    //MARK: IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        print("advertising")
//        AdvertizeController.shared.myPeri?.startAdvertising(AdvertizeController.shared.nameKey )
        AdvertizeController.shared.startAdvertizing()
    }
  
    @IBAction func stopScanning(_ sender: UIButton) {
        
        AdvertizeController.shared.myPeri?.stopAdvertising()
        AdvertizeController.shared.myPeri?.remove(AdvertizeController.shared.addServ)
        print("done advertising")
        
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        guard let myString = myTextField.text, !myString.isEmpty  else {return}
        let newString = myString
        let bytes = newString.utf8
        print(bytes)
        var buffer = [UInt8](bytes)
        buffer[0] = buffer[0] + UInt8(1)
        print(buffer)
    }

}

extension ViewController {
    
    //MARK: CBPeripheralManagerDelegate Functions
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if peripheral.state == .poweredOn {
            
            print("It's powered on!")
            
        }
        
    }
    

}











