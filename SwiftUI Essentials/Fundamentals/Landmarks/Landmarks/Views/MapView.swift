//
//  MapView.swift
//  Landmarks
//
//  Created by CL10102-M on 2022/5/13.
//

import SwiftUI
import MapKit

struct MapView: View {
    var location: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()

    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                setRegion(location)
            }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: landmarks[0].locationCoordinate)
    }
}
