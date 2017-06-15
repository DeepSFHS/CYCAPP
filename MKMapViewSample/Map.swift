//
//  ViewController.swift
//  MKMapViewSample
//
//  Created by koogawa on 2015/10/11.
//  Copyright © 2015 koogawa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Map: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: "Title", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                stores = data.components(separatedBy: "\n")
            }
            if let path = Bundle.main.path(forResource: "address", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                adresses = data.components(separatedBy: "\n")
                print (adresses?[0])
                print (adresses?[1])
                print (adresses?[2])
            }
            
            
            
        } catch let err as NSError {
            // do something with Error
            print(err)
        }

        
        
        for i in 0 ..< ((stores!.count)-1)  {
            
            let address = adresses?[i]
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil){
                    print("Error", error)
                }
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    print (coordinates)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinates
                    annotation.title = stores?[i]
                    self.mapView.addAnnotation(annotation)
                    
                }
                
            })
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let coordinate = CLLocationCoordinate2DMake(37.309098, -121.992876)
        let span = MKCoordinateSpanMake(0.0003, 0.003)
        let region = MKCoordinateRegionMake(coordinate, span)
        mapView.setRegion(region, animated:true)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MKMapView delegate
    
    // Called when the region displayed by the map view is about to change
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print(#function)
    }
    
    
    
    
    
    // Called when the annotation was added
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
            pinView?.canShowCallout = true
            pinView?.isDraggable = true
            pinView?.pinColor = .purple
            
            let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print ("YES")
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("NO")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)
        if control == view.rightCalloutAccessoryView {
            str = ((view.annotation?.title)!)!
            print (str)
            let index = stores?.index(of: str)
            addressString = (adresses?[index!])!
            
            let alertController: UIAlertController = UIAlertController(title: "Do you want to proceed?", message: "", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "No, cancel", style: .cancel) { action -> Void in
                addressString = ""
                str = ""
                
            }
            
            let nextAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
                self.performSegue(withIdentifier: "toTheMoon", sender: self)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(nextAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.ending {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func didReturnToMapViewController(_ segue: UIStoryboardSegue) {
        print(#function)
    }
}

