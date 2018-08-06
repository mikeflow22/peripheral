//
//  ViewController.swift
//  peripheral advert app
//
//  Created by Michael Flowers on 7/26/18.
//  Copyright © 2018 Michael Flowers. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController , CBPeripheralManagerDelegate  {

    
    
    var myPeri: CBPeripheralManager?
   
    var myChar = CBMutableCharacteristic(type: CBUUID(string: "EFA65E46-6B1A-456B-B2A4-163A96A40B11"), properties: .read, value: nil, permissions: .readable)
    //    let myServUUID = CBUUID(string: "9FDF7E04-BF50-4617-82CA-5667F5BBBB4E")
    var addServ = CBMutableService(type: CBUUID(string: "9FDF7E04-BF50-4617-82CA-5667F5BBBB4E"), primary: true) //primary: describes the primary functionality of a device and can be included (REFERENCED) by another service.

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myPeri = CBPeripheralManager(delegate: self, queue: nil)
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            print("It's powered on!")
        
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        print("This is the service's UUID: \(service.uuid.uuidString)")
        print("This is the service UUID Data: \(service.uuid.data)")
//        addServ.characteristics = [myChar]
        print("My services that I added: \(addServ)")
        
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
       addServ.characteristics = [myChar]
        peripheral.add(addServ)
//        myPeri = peripheral
//        print(myPeri)
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        if request.characteristic.uuid == myChar.uuid {
            print("the uuid's match")
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("advertising")
//        myPeri?.startAdvertising([CBAdvertisementDataServiceUUIDsKey : addServ.uuid])
        myPeri?.startAdvertising( [CBAdvertisementDataLocalNameKey : "HFQ" ])
    }
    
    
    @IBAction func stopScanning(_ sender: UIButton) {
        myPeri?.stopAdvertising()
        myPeri?.remove(addServ)
        print("done advertising")
    }
}

