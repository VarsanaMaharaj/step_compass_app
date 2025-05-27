import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CompassViewModel()
    @State private var heading: Double = 0.0
    
        init(viewModel: CompassViewModel? = nil) {
            if let viewModel = viewModel {
                _viewModel = StateObject(wrappedValue: viewModel)
            } else {
                // Use real services only on the actual app
                _viewModel = StateObject(wrappedValue: CompassViewModel())
            }
        }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Step Compass")
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Steps: \(viewModel.stepCount)")
                    .font(.title2)
                
                Text("Heading: \(viewModel.heading, specifier: "%.0f")°")
                    .font(.title2)
                
                Text("Position: (\(viewModel.position.x, specifier: "%.2f") m, \(viewModel.position.y, specifier: "%.2f") m)")
                    .font(.title2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.UI.cornerRadius)
            .padding(.horizontal)
            
            // Compass View
            CompassView(heading: viewModel.heading)
                .padding()
            
            Slider(value: $heading, in: 0...360, step: 1)
                .accentColor(.red)
            
            Text("Heading: \(heading, specifier: "%.0f")°")
                .font(.headline)
                .padding()
            
            Button("Reset Position") {
                viewModel.resetPosition()
            }
            .buttonStyle(.borderedProminent)
            
            HStack(spacing: 12) {
                Button("Start Tracking") {
                    viewModel.startTracking()
                }
                .buttonStyle(.bordered)
                
                Button("Stop Tracking") {
                    viewModel.stopTracking()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .onAppear {
            viewModel.startTracking()
        }
        .onDisappear {
            viewModel.stopTracking()
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CompassViewModel(
            motionService: MockMotionService(),
            positionCalculator: PositionCalculator()
        ))
    }
}
