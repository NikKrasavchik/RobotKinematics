add_library(robot_core
    STATIC
    src/Matrix4.cpp
    src/ForwardKinematics.cpp
    src/RobotModel.cpp
)

target_include_directories(robot_core
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_compile_features(robot_core
    PUBLIC
    cxx_std_20
)