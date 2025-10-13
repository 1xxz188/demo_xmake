set_languages("c++20")
set_policy("package.requires_lock", true) --依赖包锁定，防止自动升级
add_rules("mode.debug", "mode.releasedbg", "mode.profile") --profile模式(debug -pg)
set_defaultmode("debug") --等价于xmake f -m debug

set_encodings("utf-8") --支持的编码：utf-8, gb2312 (msvc) 对源文件，目标文件生效
set_exceptions("cxx")

if is_mode("debug") then
    add_defines("DEBUG")
end

if is_mode("releasedbg") then
    set_symbols("debug")
    set_optimize("fastest")
    set_strip("none")  -- 不剥离符号，保留调试信息在可执行文件中
end

if is_plat("windows") and is_mode("debug") then
    set_runtimes("MTd")
    add_requireconfs("*", {debug = true})
end

set_config("buildir", "bin")
local exe_base_dir = "$(buildir)/"   --可执行程序输出目录

add_requires("vcpkg::yaml-cpp")
add_packages("vcpkg::yaml-cpp")

target("demo1", function() 
	set_kind("binary")
    set_targetdir(exe_base_dir .. "demo1")
    add_files("src/**.cpp")

    after_build(function (target)
        os.cp("test.yaml", target:targetdir() .. "/test.yaml")
    end)
end
)