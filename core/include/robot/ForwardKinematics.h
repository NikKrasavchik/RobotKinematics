#pragma once

#include "robot/Vector3.h"
#include "robot/Matrix4.h"
#include "robot/DHParameters.h"

#include <vector>

namespace robot
{
class ForwardKinematics
{
public:
    static Matrix4 calculateDHMatrix(const DHParameters& dh);
    static Matrix4 calculateTransform(const std::vector<DHParameters>& joints);
    static std::vector<Matrix4> calculateTransforms(const std::vector<DHParameters>& joints); 
    static Vector3 calculateTCP(const std::vector<DHParameters>& joints);
};
}