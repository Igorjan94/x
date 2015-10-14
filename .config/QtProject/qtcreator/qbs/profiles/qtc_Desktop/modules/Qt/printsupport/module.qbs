import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "PrintSupport"
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
    libNameForLinkerDebug: "Qt5PrintSupport"
    libNameForLinkerRelease: "Qt5PrintSupport"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5PrintSupport.so.5.4.1"
    cpp.defines: ["QT_PRINTSUPPORT_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtPrintSupport"]
    cpp.libraryPaths: []
    
}
