Step Compass App
Overview
The Step Compass App is a simplified navigation tool designed to track user movement using step counts and directional heading. It calculates real-time positional changes and displays them alongside a dynamic visual compass. This app demonstrates key principles of working with live sensor data, mathematical position tracking, and SwiftUI interface development.
This app was built to run on both physical devices and simulators:
* Physical Devices: Uses CoreMotion to track live step counts and heading direction.
* Simulators: Simulates motion data for testing and development using a built-in mock service.
Whether you’re testing on a real device or a simulator, the app visually updates a compass and your position as you move or simulate movement.

Features
* Real-time Step Tracking: Uses CMPedometer to count steps in real-time.
* Heading Updates: Streams device heading (0–360°) using CMMotionManager.
* Position Calculation: Computes user position based on step count and heading using trigonometric formulas.
* Dynamic Compass: Displays a rotating compass element that updates smoothly with changes in heading.
* Start/Stop Controls: Begin or pause tracking with a single tap.
* Reset Position: Return your position to the origin and restart tracking.
   
How to Use
Step 1: Start the App
1. Open the Step Compass App on your device or simulator.
2. You’ll see the following on the main screen:
    * Step Count: The number of steps you’ve taken so far.
    * Heading: The direction you’re facing (e.g., 0° for North, 90° for East).
    * Position: Your current coordinates, starting from the origin (0.0, 0.0).
Step 2: Start Tracking
* Tap the Start Tracking button to begin.
* The app will:
    * Increment your step count every few seconds (or based on real steps on a device).
    * Rotate the compass to reflect your updated heading.
    * Calculate your new position based on your steps and heading.
Step 3: Pause or Stop Tracking
* Tap the Stop Tracking button to pause updates.
* The step count, heading, and position will freeze until you resume tracking.
Step 4: Reset Your Position
* Tap the Reset Position button to:
    * Reset your position back to (0.0, 0.0).
    * Restart the step count and heading tracking from the beginning.

How It Works
The Step Compass App relies on two key inputs:
1. Step Count: Tracks the number of steps you’ve taken.
2. Heading: Determines the direction you’re facing (in degrees).
Using these inputs, the app calculates your position with the following formulas:
* X Coordinate: x += stepLength * cos(headingRadians)
* Y Coordinate: y += stepLength * sin(headingRadians)
The default step length is 0.75 meters.

For First-Time Users
Running the App
1. On a Physical Device:
    * The app will track your actual steps and heading using your device’s sensors.
2. On a Simulator:
    * The app uses mock data to simulate movement. Step count increases every 2 seconds, and the heading rotates by 15° increments.
Watching the App in Action
* Start tracking to see the compass needle rotate and your position update in real time.
* Tap reset to experiment with starting from a new position.

Build and Run Instructions
Requirements
* Xcode: Version 14.0 or higher
* Swift: Version 5.7 or higher
* iOS Deployment Target: iOS 15.0 or later
1. Clone the repository or unzip the project files.
2. Open the project in Xcode.
3. Select a physical device or simulator.
4. Run the app by clicking the Run button in Xcode or pressing Cmd + R.

Key Assumptions
1. Mock Data in the Simulator:
    * Since CoreMotion sensors are unavailable in the simulator, we assume that MockMotionService accurately represents real-world step count and heading data.
    * Step count increments by 10 every 2 seconds, and heading changes by 15° every 2 seconds.
2. Fixed Step Length:
    * The app assumes a constant step length of 0.75 meters for position calculations. This is suitable for demonstration but may not represent all users.
3. Coordinate System:
    * The position is calculated using Cartesian coordinates, with (0.0, 0.0) as the origin. Heading is measured in degrees, where 0° corresponds to North.

Potential Improvements
* Customizable Step Length: Allow users to input their step length for better accuracy.
* Path Visualization: Add a feature to visualize the user’s path on a map.
* Session History: Save session data to review past movements.
* Accessibility Enhancements: Include voice guidance and haptic feedback.

Contact
For any questions or suggestions, please reach out to the developer through GitHub.

Enjoy exploring the Step Compass App!
