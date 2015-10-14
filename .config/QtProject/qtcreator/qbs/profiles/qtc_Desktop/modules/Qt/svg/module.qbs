import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "Svg"
    Depends { name: "Qt"; submodules: ["core", "gui", "widgets"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/libQt5Widgets.so.5.4.1", "/usr/lib/libQt5Gui.so.5.4.1", "/usr/lib/libQt5Core.so.5.4.1", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5Svg"
    libNameForLinkerRelease: "Qt5Svg"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5Svg.so.5.4.1"
    cpp.defines: ["QT_SVG_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtSvg"]
    cpp.libraryPaths: []
    
}
