import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "XmlPatterns"
    Depends { name: "Qt"; submodules: ["core", "network"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/libQt5Network.so.5.4.0", "/usr/lib/libQt5Core.so.5.4.0", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5XmlPatterns"
    libNameForLinkerRelease: "Qt5XmlPatterns"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5XmlPatterns.so.5.4.0"
    cpp.defines: ["QT_XMLPATTERNS_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtXmlPatterns"]
    cpp.libraryPaths: []
    
}
