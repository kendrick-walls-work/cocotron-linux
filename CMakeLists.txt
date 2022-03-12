project(cocotron)

if(FLATPAK_BUILD)
	# For some reason, some of the header files are not included in the 
	# `/usr/include` directory.
	include_directories("/usr/lib/x86_64-linux-gnu/include")
endif(FLATPAK_BUILD)

add_subdirectory(CoreGraphics)
add_subdirectory(Onyx2D)
add_subdirectory(AppKit)
add_subdirectory(CoreText)
add_subdirectory(Cocoa)
add_subdirectory(CoreData)
add_subdirectory(QuartzCore)
