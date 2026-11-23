#pragma once

namespace robot
{
inline constexpr double  pi = 3.141592;

constexpr double degreesToRadians(double degrees)
{
    return degrees * pi / 180.0;
}

constexpr double radiansToDegrees(double radians)
{
    return radians * 180.0 / pi;
}
}