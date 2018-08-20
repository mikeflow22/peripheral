//
//  AdvertizeController.swift
//  peripheral advert app
//
//  Created by Michael Flowers on 8/15/18.
//  Copyright © 2018 Michael Flowers. All rights reserved.
//

import Foundation
import CoreBluetooth

class AdvertizeController:  NSObject , CBPeripheralManagerDelegate  {
    
    static let shared = AdvertizeController()
    
    //MARK: Properties
    var myPeri: CBPeripheralManager?
    var myChar = CBMutableCharacteristic(type: CBUUID(string: "EFA65E46-6B1A-456B-B2A4-163A96A40B11"), properties: .read, value: nil, permissions: .readable)
    //    let myServUUID = CBUUID(string: "9FDF7E04-BF50-4617-82CA-5667F5BBBB4E")
    var addServ = CBMutableService(type: CBUUID(string: "9FDF7E04-BF50-4617-82CA-5667F5BBBB4E"), primary: true) //primary: describes the primary functionality of a device and can be included (REFERENCED) by another service.
    var nameKey = [CBAdvertisementDataLocalNameKey : "HFQ" ]
}

extension AdvertizeController {
    
    //MARK: Delegate Functions
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if peripheral.state == .poweredOn {
            
            print("Bluetooth is on!")
            
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        
        if let error = error {
            
            print("\(error.localizedDescription) \(error) \(#function)")
            
        } else {
            
            print("This is the service's UUID: \(service.uuid.uuidString)")
            print("This is the service UUID Data: \(service.uuid.data)")
            //        addServ.characteristics = [myChar]
            print("My services that I added: \(addServ)")
    
        }
    }
    
    func startAdvertizing(){
        myPeri?.startAdvertising([CBAdvertisementDataLocalNameKey : nameKey])
    }
    
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        
        if let error = error {
            
            print(error.localizedDescription)
            
        } else {
            
            addServ.characteristics = [myChar]
            peripheral.add(addServ)
            
        }

    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        
        if request.characteristic.uuid == myChar.uuid {
            
            print("the uuid's match")
            
        }
    }
}
