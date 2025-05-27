import SwiftUI

struct CompassView: View {
    var heading: Double
        
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 2)
                .frame(width: 200, height: 200)
            
            VStack {
                Text("N")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(height: 100)
            
            HStack {
                Text("W")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text("E")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .frame(width: 100)
            
            VStack {
                Spacer()
                Text("S")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .frame(height: 100)
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 4, height: 80)
                .offset(y: -40)
                .rotationEffect(.degrees(-heading))
                .animation(.easeInOut(duration: 0.3), value: heading)
            
            Circle()
                .fill(Color.black)
                .frame(width: 10, height: 10)
        }
        .frame(width: 200, height: 200)
    }
}

// MARK: - Preview

struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView(heading: 45)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
