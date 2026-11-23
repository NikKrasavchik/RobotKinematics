#include "robot/Matrix4.h"

#include <stdexcept>

namespace robot 
{
Matrix4::Matrix4() = default;

Matrix4 Matrix4::identity()
{
    Matrix4 result;
    for (std::size_t i = 0; i < 4; i++)
        result(i, i) = 1.0;

    return result;
}

double& Matrix4::operator()(std::size_t row, std::size_t col)
{
    if (row >= 4 || col >= 4)
        throw std::out_of_range("Matrix4 index out of range");

    return data_[row*4 + col];
}

double Matrix4::operator()(std::size_t row, std::size_t col) const
{
    if (row >= 4 || col >= 4)
        throw std::out_of_range("Matrix4 index out of range");

    return data_[row*4 + col];
}

Matrix4 Matrix4::operator*(const Matrix4& other) const
{
    Matrix4 result;

    for (std::size_t row = 0; row < 4; row++)
        for (std::size_t col = 0; col < 4; col++)
        {
            double sum = 0.0;

            for (std::size_t k = 0; k < 4; k++)
                sum += (*this)(row, k) * other(k, col);

            result(row, col) = sum;
        }
    
    return result;
}

Vector3 Matrix4::translation() const
{
    return {
        (*this)(0, 3),
        (*this)(1, 3),
        (*this)(2, 3)
    };
}
}