import math
import numpy as np

def cordic_model(x, y, z, coordinate, mode, itr):
    if coordinate == 1:
        t = 1
    elif coordinate == 2:
        t = 0
    elif coordinate == 3:
        t = -1
    else:
        raise ValueError("Invalid coordinate value. Should be 1, 2, or 3.")

    for n in range(itr + 1):
        if coordinate == 3:  # hyperbolic CORDIC starts from n+1
            n2 = n + 1
        else:
            n2 = n

        # Rotation angle or linear scale based on coordinate
        if coordinate == 1:
            g = math.atan(2 ** -n2)
        elif coordinate == 2:
            g = 2 ** -n2
        elif coordinate == 3:
            g = math.atanh(2 ** -n2)

        # Determine direction
        if mode == 1:
            d = np.sign(z)
        elif mode == 2:
            d = -np.sign(x * y)
        else:
            raise ValueError("Invalid mode. Should be 1 or 2.")

        if d == 0:
            d = -1

        x2 = x - d * y * (2 ** -n2) * t
        y2 = y + d * x * (2 ** -n2)
        z2 = z - d * g

        x, y, z = x2, y2, z2

    return x, y, z

if __name__ == "__main__":
    # Example: CORDIC in rotation mode, circular coordinate system
    x = 1.0
    y = 0.0
    z =  math.radians(31)
    coordinate = 1  # circular
    mode = 1        # rotation
    itr = 18        # number of iterations

    x_out, y_out, z_out = cordic_model(x, y, z, coordinate, mode, itr)
    angle_rad = math.atan2(y_out, x_out)  # angle in radians
    angle_deg = math.degrees(angle_rad)   # convert to degrees

    print("CORDIC Output:")
    print(f"x: {x_out}")
    print(f"y: {y_out}")
    print(f"z: {z_out}")
    print(f"Angle (radians): {angle_rad}")
    print(f"Angle (degrees): {angle_deg}")

    # lenght of (x,y) vector
    length = math.sqrt(x_out**2 + y_out**2)
    print(f"Length of vector: {length}")

    # Correct length
    correct_length = length * 0.60725
    print(f"Correct length: {correct_length}")