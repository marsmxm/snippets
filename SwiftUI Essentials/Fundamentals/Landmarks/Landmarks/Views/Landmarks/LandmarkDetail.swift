//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by CL10102-M on 2022/5/17.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark
    
    var landmarkIndex: Int {
       modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        VStack {
            MapView(location: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }
                
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
                
            }
            .padding()
            
            Spacer()
        }
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks[1])
            .environmentObject(modelData)
    }
}
