//
//  MapaViewController.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 10/05/22.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

class MapaViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    var selectedAddress: Address? = nil
    let locationManager: CLLocationManager = CLLocationManager()
    var lastLocation: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: -23.5503099, longitude: -46.6342009)
    
    var carona: Carona?

    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.text = carona?.localInicio
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(true)
           mapView.showsUserLocation = true
           locationManager.startUpdatingLocation()
           
           if let address = selectedAddress {
               showRoute(address)
           }
       }
    
    
    @IBAction func tappedShowAddress(_ sender: Any) {
        getPossibleAddressesFromText()
    }
    
    
    private func showRoute(_ address: Address) {
            let destinationAnnotation        = MKPointAnnotation()
            destinationAnnotation.coordinate = address.placemark.location!.coordinate
            destinationAnnotation.title      = address.name
            self.mapView.addAnnotation(destinationAnnotation)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: lastLocation!))
            request.destination = MKMapItem(placemark: MKPlacemark(placemark: address.placemark))
            if carona?.categoria.tipo == "A pé" {
                request.transportType = .walking
            }
            else if carona?.categoria.tipo == "Trem" || carona?.categoria.tipo == "Metrô" {
                request.transportType = .transit
            }
            else {
                request.transportType = .automobile
            }
            let directions = MKDirections(request: request)
            
            directions.calculate { (response, error) in
                guard let unwrappedResponse = response else { return }
                
                
                
                for route in unwrappedResponse.routes {
                    self.mapView.addOverlay(route.polyline)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
        }
    
    private func getPossibleAddressesFromText() {
        var addresses: [Address] = []
        CLGeocoder().geocodeAddressString(addressTextField.text!) { (placemarks, error) in
            if error == nil {
                for placemark in placemarks! {
                    addresses.append(self.convertToAddress(placemark: placemark))
                }
                self.showAddressesTable(addresses: addresses)
            } else {
                let controller = UIAlertController(title: "Error", message: "Problema ao encontrar o endereço", preferredStyle: UIAlertController.Style.alert)
                controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(controller,animated: true, completion: nil)
            }
        }
    }
    
    private func convertToAddress(placemark: CLPlacemark) -> Address {
        return Address(name: placemark.postalAddress!.street, placemark: placemark, postalAddress: placemark.postalAddress!);
    }
    
   private func showAddressesTable(addresses: [Address]) {
       let addressesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddressesTableViewController") as! AddressesTableViewController
       addressesVC.addresses = addresses
       addressesVC.selectedAddress = { address in
           self.selectedAddress = address
       }
       self.navigationController?.pushViewController(addressesVC, animated: true)
   }
}




extension MapaViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        self.lastLocation = location?.coordinate
        mapView.centerCoordinate = location!.coordinate
        let region = mapView.regionThatFits(MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 600, longitudinalMeters: 600))
        mapView.setRegion(region, animated: false)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MapaViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .orange
        renderer.lineWidth = 5.0
        return renderer
    }
}

