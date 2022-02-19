//
//  locationFinder.swift
//  Recycling Locator
//
//  Created by Benjamin White on 2/19/22.
//
import Foundation



struct Coordinate {
    var latitude: String
    var longitude: String
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

        

        let latitude = columns[4]

        let longitude = columns[5]

        

        let coordinate = Coordinate(latitude: latitude, longitude: longitude)

        

        allLocations.append(coordinate)

    }

    

    print(allLocations)

    

}
