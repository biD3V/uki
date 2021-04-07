TARGET := iphone:clang:latest:13.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ukiprefs

ukiprefs_FILES = UKIRootListController.m
ukiprefs_FRAMEWORKS = UIKit
ukiprefs_PRIVATE_FRAMEWORKS = Preferences
ukiprefs_INSTALL_PATH = /Library/PreferenceBundles
ukiprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
