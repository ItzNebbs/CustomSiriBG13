INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomSiriBG13

CustomSiriBG13_FILES = $(wildcard *.xm)
CustomSiriBG13_EXTRA_FRAMEWORKS = Cephei
CustomSiriBG13_CFLAGS = -fobjc-arc

SUBPROJECTS = prefs

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk