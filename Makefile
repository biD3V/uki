TARGET := iphone:clang:latest:13.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = Sileo


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = uki

$(TWEAK_NAME)_FILES = UIView+Constraints.m UKIPrefs.m Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += ukiprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
