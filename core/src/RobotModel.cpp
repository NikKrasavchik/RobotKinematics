#include "robot/RobotModel.h"
#include "robot/MathUtils.h"

#include <cmath>
#include <stdexcept>
#include <utility>

namespace robot
{
RobotModel::RobotModel(std::string name, std::vector<DHParameters> joints)
    : name_(std::move(name)), joints_(std::move(joints))
{
    initialAngles_.reserve(joints_.size());
    for (const DHParameters& joint : joints)
        initialAngles_.push_back(joint.theta);
}

double RobotModel::jointAngle(std::size_t index) const
{
    return joints_.at(index).theta;
}

void RobotModel::setJointAngle(std::size_t index, double angle)
{
    if (!std::isfinite(angle))
        throw std::invalid_argument("Joint angle must be finite");

    joints_.at(index).theta = angle;
}

void RobotModel::resetAngles()
{
    for (std::size_t i = 0; i < joints_.size(); i++)
        joints_[i].theta = initialAngles_[i];
}

RobotModel RobotModel::createRB6A()
{
    return RobotModel(
        "RB-6A",
        {
            {degreesToRadians(12), 0.0, 0.200, pi/2},
            {degreesToRadians(30), -0.5, 0.130, 0.0},
            {degreesToRadians(-45), -0.450, -0.15, 0.0},
            {degreesToRadians(20), 0.0, 0.20, pi/2},
            {degreesToRadians(60), 0.0, 0.23, -pi/2},
            {degreesToRadians(10), 0.0, 0.20, 0.0}
        }
    );
}

RobotModel RobotModel::createRB6B()
{
    return RobotModel(
        "RB-6B",
        {
            {degreesToRadians(15), 0.0, 0.185, pi/2},
            {degreesToRadians(-40), -0.6, 0.120, 0.0},
            {degreesToRadians(55), -0.420, -0.14, 0.0},
            {degreesToRadians(-20), 0.0, 0.19, pi/2},
            {degreesToRadians(70), 0.0, 0.22, -pi/2},
            {degreesToRadians(35), 0.0, 0.18, 0.0}
        }
    );
}

RobotModel RobotModel::createRB6C()
{
    return RobotModel(
        "RB-6C",
        {
            {degreesToRadians(-10), 0.0, 0.250, pi/2},
            {degreesToRadians(40), -0.7, 0.150, 0.0},
            {degreesToRadians(-25), -0.500, -0.16, 0.0},
            {degreesToRadians(45), 0.0, 0.22, pi/2},
            {degreesToRadians(-30), 0.0, 0.25, -pi/2},
            {degreesToRadians(0), 0.0, 0.22, 0.0}
        }
    );
}
}