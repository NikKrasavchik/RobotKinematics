#include "robot/ForwardKinematics.h"

#include <cmath>

namespace robot
{
Matrix4 ForwardKinematics::calculateDHMatrix(const DHParameters& dh)
{
    const double ct = std::cos(dh.theta);
    const double st = std::sin(dh.theta);
    const double ca = std::cos(dh.alpha);
    const double sa = std::sin(dh.alpha);

    Matrix4 result = Matrix4::identity();

    result(0, 0) = ct;
    result(0, 1) = -st * ca;
    result(0, 2) = st * sa;
    result(0, 3) = dh.a * ct;

    result(1, 0) = st;
    result(1, 1) = ct * ca;
    result(1, 2) = -ct * sa;
    result(1, 3) = dh.a * st;

    result(2, 0) = 0.0;
    result(2, 1) = sa;
    result(2, 2) = ca;
    result(2, 3) = dh.d;

    return result;
}

Matrix4 ForwardKinematics::calculateTransform(const std::vector<DHParameters>& joints)
{
    Matrix4 result = Matrix4::identity();

    for (const DHParameters& joint : joints)
    {
        const Matrix4 transform = calculateDHMatrix(joint);
        result = result * transform;
    }

    return result;
}

std::vector<Matrix4> ForwardKinematics::calculateTransforms(const std::vector<DHParameters>& joints)
{
    std::vector<Matrix4> transforms;
    transforms.reserve(joints.size() + 1);

    Matrix4 current = Matrix4::identity();
    transforms.push_back(current);

    for (const DHParameters& joint : joints)
    {
        current = current * calculateDHMatrix(joint);
        transforms.push_back(current);
    }

    return transforms;
}

Vector3 ForwardKinematics::calculateTCP(const std::vector<DHParameters>& joints)
{
    const Matrix4 transform = calculateTransform(joints);

    return transform.translation();
}
}