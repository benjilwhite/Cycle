//
//  ContentView.swift
//  Recycling Locator
//
//  Created by Benjamin White on 2/19/22.
//

import SwiftUI
import MapKit


struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "xmark.circle").padding(10)
            }.offset(y: -350).font(.system(size: 30))
            
            Text("What are you looking to get rid of?").font(.system(size: 22, weight: .regular, design: .serif)).offset(y: -300)
            
            Button(action: {
                      print("button pressed")

                    }) {
                        Image("Cans")
                            .resizable().frame(width: 100, height: 100)
                    }
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    
    @State private var isPresented = false
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.779715, longitude: -73.967049),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).edgesIgnoringSafeArea(.all)
                
                Button("Menu") {
                    self.isPresented.toggle()
                }
                .font(.system(size: 40, weight: .heavy, design: .serif))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 100)
                .background(Color.black.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(y: 300)
                .fullScreenCover(isPresented: $isPresented, content: ModalView.init)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
