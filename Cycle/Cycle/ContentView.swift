//
//  ContentView.swift
//  Recycling Locator
//
//  Created by Benjamin White on 2/19/22.
//

import SwiftUI
import MapKit
import Combine

//main popup menu
struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "xmark.circle").padding(10)
            }.font(.system(size: 30))
            
            Text("What are you looking to get rid of?").font(.system(size: 22, weight: .regular, design: .serif))
            
            //where its says "action" for the buttons, replace that with what the button does.
            HStack {
                VStack {
                    Button(action: { print("button pressed") }) {
                        Image("Cans").resizable().frame(width: 125, height: 125)
                    }
                    Text("Cans")
                }
                VStack {
                    Button(action: { print("button pressed") }) {
                        Image("Food Waste").resizable().frame(width: 125, height: 125)
                    }
                    Text("Food Scraps")
                }
            }
            HStack {
                VStack {
                    Button(action: { print("button pressed") }) {
                        Image("Glass").resizable().frame(width: 125, height: 125)
                    }
                    Text("Glass")
                }
                VStack {
                    Button(action: { print("button pressed") }) {
                        Image("Paper").resizable().frame(width: 125, height: 125)
                    }
                    Text("Paper")
                }
            }
            HStack {
                VStack {
                    Button(action: { print("button pressed") }) {
                        Image("Plastic Bottles").resizable().frame(width: 125, height: 125)
                    }
                    Text("Plastic Bottles")
                }
                VStack {
                    Button(action: { print("button pressed") }) {
                        Image("Trash Can").resizable().frame(width: 125, height: 125)
                    }
                    Text("Other Trash")
                }
            }
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {

    @State private var isPresented = false //bool whether or not menu is displayed

    //import and store the location
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    @State private var cancellable: AnyCancellable?
        
    private func setCurrentLocation() {
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                //place the user on the map, if a location can be found
                if locationManager.location != nil {
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil).ignoresSafeArea()
                } else {
                        Text("Locating user...")
                    }
                }
                .onAppear {
                    setCurrentLocation()
                }
            //menu button
            Button("Menu") {
                self.isPresented.toggle()
            }
                .font(.system(size: 40, weight: .heavy, design: .serif))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 100)
                .background(Color.black.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(y: 350)
                .fullScreenCover(isPresented: $isPresented, content: ModalView.init)
            }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}



