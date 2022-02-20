//
//  locationFinder.swift
//  Recycling Locator
//
//  Created by Viraj Mehta on 2/19/22.
//
import Foundation

struct Coordinate {
    var latitude: Double
    var longitude: Double
    
    var hashValue: Int {
        return latitude.hashValue
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

var allLocations = [Coordinate]()

func readCSV(){
    guard let filepath = Bundle.main.path(forResource: "Public_Recycling_Bins", ofType: "csv") else {
        return
    }

    var data = ""
    do {
        data = try String(contentsOfFile: filepath)
    } catch {
        print(error)
        return
    }

    let rows = data.components(separatedBy: "\n")
    for row in rows {
        let columns = row.components(separatedBy: ",")
        let latitude = Double(columns[4])
        let longitude = Double(columns[5])
        let coordinate = Coordinate(latitude: latitude!, longitude: longitude!)
        allLocations.append(coordinate)

    }
    debugPrint(allLocations)
}

// Implementation of Haversine formula to get 10 nearest locations
var nearestLocations = [Double]()
var nearestLocationsMap = [Double: Coordinate]()

var finalLocations = [Coordinate]()

// Placeholder initializer for user's location
var userLocation = Coordinate(latitude: 0.0, longitude: 0.0)

func getNearestLocations() -> [Coordinate] {
    let radius = 6371.0
    var counter = 0
    
    for location in allLocations {
        let diffLat = (location.latitude - userLocation.latitude) * (Double.pi / 180)
        let diffLong = (location.longitude - userLocation.longitude) * (Double.pi / 180)
        
        let a =
            sin(diffLat/2) * sin(diffLat/2) +
            cos(location.latitude * (Double.pi/180)) * cos(userLocation.latitude * (Double.pi/180)) *
            sin(diffLong/2) * sin(diffLong/2)
            ;
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        let d = radius * c; // Distance in km
        nearestLocationsMap[d] = location
        
        if (counter < 10) {
            nearestLocations.append(d)
            counter += 1
        }
        else {
            for index in 0...9 {
                if (d < nearestLocations[index]) {
                    nearestLocations[index] = d
                }
            }
        }
    }
    
    for (distance, coordinate) in nearestLocationsMap {
        if (nearestLocations.contains(distance)) {
            finalLocations.append(coordinate)
        }
    }
    
    return finalLocations
}
