cmake_minimum_required(VERSION 3.13.0)
project(foo LANGUAGES C CXX ASM)

#add_library(foo STATIC "")
option(BUILD_SHARED_LIBS "Build foo as shared library" OFF)
if(BUILD_SHARED_LIBS)
add_library(foo SHARED "")
# 确保在Windows上生成导入库文件
set_target_properties(foo PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
else()
add_library(foo STATIC "")
endif()

target_sources(foo PRIVATE
    src/foo.c
)
set_target_properties(foo PROPERTIES PUBLIC_HEADER src/foo.h)
include(GNUInstallDirs)
install(TARGETS foo
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

