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


struct ContentView2: View {
    @State var shouldShowShimmer = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .modifier(CustomShimmer(shouldShow: shouldShowShimmer))
            Text("Hello, world!")
                .modifier(CustomShimmer(shouldShow: shouldShowShimmer))
            
            Button("Toogle Skeleton 🩻") {
                shouldShowShimmer.toggle()
            }
        }
        .padding()
    }
    
}

extension View {
    
}

struct CustomShimmer: ViewModifier {
    var shouldShow: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .overlay {
                    if shouldShow {
                        SkeletonView()
                    }
                }
        }
    }
}


struct SkeletonView: View {
    @State private var show = false
    private var center = (UIScreen.main.bounds.width / 2) + 110
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(10)
            
            Color.black.opacity(0.09)
                .cornerRadius(10)
            
            Color.white
                .cornerRadius(10)
            
                .mask {
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: show ? center : -center)
                }
            
        }
        .onAppear {
            withAnimation(.default.speed(0.15).delay(0).repeatForever(autoreverses: false)) {
                self.show.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
