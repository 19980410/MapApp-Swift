//
//  ViewController.swift
//  MapApp
//
//  Created by poti on 2020/04/13.
//  Copyright © 2020 kaoru. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, SearchLocationDelegete {

    

    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    var locManager: CLLocationManager!
    var addressString = String()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        settingButton.backgroundColor = .white
        settingButton.layer.cornerRadius = 20.0
        
    }

    @IBAction func lomgPressTap(_ sender: UILongPressGestureRecognizer) {
        //start tap
        //sender is state of longTap
        if sender.state == .began{
            
        }else if sender.state == .ended{
            //タップした位置を指定して、MKMapView上の緯度経度を取得
            //緯度経度から位置情報を取得
            
            //viweの中のtachしたlocationを取得
            let tapPoint = sender.location(in: view)
            
            //タップした位置（CDpoint）を指定してMKMAPView上の緯度・径度を取得
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            print(center)
            let lat = center.latitude
            let log = center.longitude
            convert(lat: lat, log: log)
        }
    }
    
    func convert(lat: CLLocationDegrees, log: CLLocationDegrees){
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        //値が入った後にカッコ内が呼ばれ、値が入るまではカッコのそとが呼ばれる
        geocoder.reverseGeocodeLocation(location){(placeMark, error) in
            if let placeMark = placeMark{
                
                if let pm = placeMark.first{
                    if pm.administrativeArea != nil || pm.locality != nil{
                        //クロージャの中ではグローバル変数（メンバ変数）には、selfをつける
                        self.addressString = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{
                        //代表的な名前（東京タワーとか）があればそちらを優先
                        self.addressString = pm.name!
                    }
                    
                    self.addressLabel.text = self.addressString
                }
            }
        }
    }
    
    
    
    @IBAction func goToSearchVC(_ sender: Any) {
        //page
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let nextVC = segue.destination as! NextViewController
            nextVC.delegate = self
        }
    }
    
    //任されたデリゲードメソッド
    func searchLocation(idoValue: String, keidoValue: String) {
        
        if idoValue.isEmpty != true && keidoValue.isEmpty != true{
            
            let idoString = idoValue
            let keidoString = keidoValue
            
            //緯度経度からコーディネート
            let coordinate = CLLocationCoordinate2DMake(Double(idoString)!, Double(keidoString)!)
            
            //表示する範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

            //領域を指定
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            //領域をmapviewに設定
            mapView.setRegion(region, animated: true)
            
            //緯度経度から住所へ変換
            convert(lat: Double(idoString)!, log: Double(keidoString)!)
            
            //ラベルに表示
            addressLabel.text = addressString
            
        }else{
            addressLabel.text = "表示できません"
        }
    }
    
}

