#pragma once

#include "robot/Vector3.h"

#include <array>
#include <cstddef>

namespace robot
{
class Matrix4
{
public:
    Matrix4();

    static Matrix4 identity();

    double& operator()(std::size_t row, std::size_t col);
    double operator()(std::size_t row, std::size_t col) const;
    Matrix4 operator*(const Matrix4& other) const;

    Vector3 translation() const;

private:
    std::array<double, 16> data_{};
};
}