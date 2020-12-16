cmake_minimum_required(VERSION 3.14)

project(curs LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick QuickControls2 REQUIRED)

set(PROJECT_SOURCES
        main.cpp
#        data.cpp
#        selling.cpp
        qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(curs
        ${PROJECT_SOURCES}
    )
else()
    if(ANDROID)
        add_library(curs SHARED
            ${PROJECT_SOURCES}
            ${PROJECT_MOC_OUTFILES}
        )
    else()
        add_executable(curs
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(curs
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(curs
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::QuickControls2)

# Dependencies
add_subdirectory(dependencies)
target_link_libraries(curs PRIVATE sqlite_orm::sqlite_orm)
