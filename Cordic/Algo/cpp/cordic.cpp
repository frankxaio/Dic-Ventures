#include <iostream>   // For input/output (cout, endl)
#include <cmath>      // For math functions (atan, atanh, pow)
#include <vector>     // For dynamic array (vector)

using namespace std;  // Use standard library namespace to avoid std:: prefix

// Enums for CORDIC mode
enum class CordicMode { ROTATION, VECTORING };

// Enums for coordinate system type
enum class CoordinateSystem { CIRCULAR, LINEAR, HYPERBOLIC };

// CORDIC class encapsulating algorithm logic
class Cordic {
public:
    // Constructor: initialize with mode, system, and number of iterations
    Cordic(CordicMode mode, CoordinateSystem system, int iterations)
        : mode_(mode), system_(system), iterations_(iterations) {
        initAngleTable();  // Precompute the angle table
    }

    // Function to perform the CORDIC computation on input vector (x, y, z)
    void compute(double& x, double& y, double& z) const {
        // Iterate through each stage of CORDIC rotation/scaling
        for (int i = 0; i < iterations_; ++i) {
            double x_new, y_new, z_new;

            // Determine the direction (sigma) based on mode:
            // In rotation mode, depends on z sign (desired angle)
            // In vectoring mode, depends on y sign (vector magnitude)
            int sigma = (mode_ == CordicMode::ROTATION) ? ((z >= 0) ? 1 : -1)
                                                         : ((y >= 0) ? 1 : -1);

            // Compute 2^-i shift (equivalent to binary shift right in hardware)
            double shift = pow(2, -i);

            // Apply different coordinate system transformations
            switch (system_) {
                case CoordinateSystem::CIRCULAR:
                    // Circular rotation equations
                    x_new = x - sigma * y * shift;
                    y_new = y + sigma * x * shift;
                    z_new = z - sigma * angleTable_[i];
                    break;

                case CoordinateSystem::LINEAR:
                    // Linear scaling equations (used for linear functions)
                    x_new = x;
                    y_new = y + sigma * x * shift;
                    z_new = z - sigma * angleTable_[i];
                    break;

                case CoordinateSystem::HYPERBOLIC:
                    // Hyperbolic rotation equations (for sinh, cosh)
                    x_new = x + sigma * y * shift;
                    y_new = y + sigma * x * shift;
                    z_new = z - sigma * angleTable_[i];
                    break;
            }

            // Update x, y, z for the next iteration
            x = x_new;
            y = y_new;
            z = z_new;
        }
    }

private:
    CordicMode mode_;                 // Rotation or vectoring mode
    CoordinateSystem system_;         // Coordinate system type
    int iterations_;                  // Number of iterations for precision
    vector<double> angleTable_;       // Precomputed angle/scaling values

    // Function to initialize the angle/scaling table based on coordinate system
    void initAngleTable() {
        angleTable_.resize(iterations_);  // Allocate angle table size
        for (int i = 0; i < iterations_; ++i) {
            switch (system_) {
                case CoordinateSystem::CIRCULAR:
                    // atan(2^-i) for circular rotations
                    angleTable_[i] = atan(pow(2, -i));
                    break;
                case CoordinateSystem::LINEAR:
                    // Direct shift factor (2^-i) for linear scaling
                    angleTable_[i] = pow(2, -i);
                    break;
                case CoordinateSystem::HYPERBOLIC:
                    // atanh(2^-i) for hyperbolic rotations
                    angleTable_[i] = atanh(pow(2, -i));
                    break;
            }
        }
    }
};

// Main function to demonstrate CORDIC usage
int main() {
    // Initial vector to be rotated (x, y) and angle z (in radians)
    double x = 1.0;
    double y = 0.0;
    double z = M_PI / 4;  // 45 degrees in radians
    int iterations = 13;  // Number of iterations for precision

    // Create a CORDIC object in rotation mode using circular coordinate system
    Cordic cordic(CordicMode::ROTATION, CoordinateSystem::CIRCULAR, iterations);

    // Perform the CORDIC rotation (updates x, y, z)
    cordic.compute(x, y, z);

    // Print the final rotated vector and residual angle
    cout << "CORDIC Result:\n";
    cout << "  x = " << x << "\n";
    cout << "  y = " << y << "\n";
    cout << "  z = " << z << "\n";

    return 0;
}
