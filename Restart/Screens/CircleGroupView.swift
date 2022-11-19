//
//  CircleGroupView.swift
//  Restart
//
//  Created by Adithyah Nair on 19/11/22.
//

import SwiftUI

struct CircleGroupView: View {
    // MARK: - Properties

    @State var circleColor: Color
    @State var circleOpacity: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(circleColor.opacity(circleOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(circleColor.opacity(circleOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            CircleGroupView(circleColor: .white, circleOpacity: 0.2)
        }
    }
}
