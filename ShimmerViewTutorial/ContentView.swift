import SwiftUI

struct ContentView: View {
    @State var maskXOffset = CGFloat(0)
    @State var maskYOffset = CGFloat(0)
    @State var maskFrameHeight = CGFloat(100)
    @State var maskOpacity = 0.0
        
    var body: some View {
        VStack {
//            Image(systemName: "person.3.sequence")
//                .foregroundColor(Color.blue)
//            //                .clipShape(Circle())
//                .font(.system(size: 128, weight: .light))
//                .mask(alignment: .bottom) {
//                    Rectangle()
//                        .opacity(0.4)
//                        .frame(height: 65)
//                }
//
//            Image("arara")
//                .resizable()
//                .scaledToFit()
//                .mask(alignment: .center) {
//                    Image(systemName: "wifi")
//                        .resizable()
//                }
            
            Image("arara")
                .resizable()
                .scaledToFit()
                .mask(alignment: .leading) {
                    GeometryReader { proxy in
                        Circle()
                            .frame(width: maskFrameHeight, height: maskFrameHeight)
                            .offset(x: maskXOffset, y: maskYOffset)
                            .opacity(maskOpacity)
                            .onAppear {
                                startAnimation(proxy: proxy)
                            }
                    }
                }
        }
    }
    
    private func startAnimation(proxy: GeometryProxy) {
        withAnimation(.default.speed(0.5)) {
            maskOpacity = 1
            maskXOffset += (proxy.size.width - 50)
        }

        withAnimation(.interpolatingSpring(stiffness: 180, damping: 20).delay(0.5)) {
            maskXOffset -= (proxy.size.width/2)
        }

        withAnimation(.default.speed(0.4).delay(1.3)) {
            maskXOffset = -100
            maskYOffset -= 350
            maskFrameHeight += 700
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
