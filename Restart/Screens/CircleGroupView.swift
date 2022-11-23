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
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(circleColor.opacity(circleOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(circleColor.opacity(circleOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .opacity(isAnimating ? 1 : 0)
        .blur(radius: isAnimating ? 0 : 10)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear {
            isAnimating = true
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
