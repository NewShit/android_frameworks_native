LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	IGraphicBufferConsumer.cpp \
	IConsumerListener.cpp \
	BitTube.cpp \
	BufferItemConsumer.cpp \
	BufferQueue.cpp \
	ConsumerBase.cpp \
	CpuConsumer.cpp \
	DisplayEventReceiver.cpp \
	GLConsumer.cpp \
	GraphicBufferAlloc.cpp \
	GuiConfig.cpp \
	IDisplayEventConnection.cpp \
	IGraphicBufferAlloc.cpp \
	IGraphicBufferProducer.cpp \
	ISensorEventConnection.cpp \
	ISensorServer.cpp \
	ISurfaceComposer.cpp \
	ISurfaceComposerClient.cpp \
	LayerState.cpp \
	Sensor.cpp \
	SensorEventQueue.cpp \
	SensorManager.cpp \
	Surface.cpp \
	SurfaceControl.cpp \
	SurfaceComposerClient.cpp \
	SyncFeatures.cpp \

LOCAL_SHARED_LIBRARIES := \
	libbinder \
	libcutils \
	libEGL \
	libGLESv2 \
	libsync \
	libui \
	libutils \
	liblog

ifeq ($(call is-board-platform-in-list, mpq8092), true)
    LOCAL_CFLAGS            += -DVFM_AVAILABLE
endif

ifeq ($(BOARD_EGL_NEEDS_LEGACY_FB),true)
    LOCAL_CFLAGS += -DBOARD_EGL_NEEDS_LEGACY_FB
    ifneq ($(TARGET_BOARD_PLATFORM),exynos4)
        LOCAL_CFLAGS += -DSURFACE_SKIP_FIRST_DEQUEUE
    endif
endif

ifeq ($(BOARD_EGL_SKIP_FIRST_DEQUEUE),true)
    LOCAL_CFLAGS += -DSURFACE_SKIP_FIRST_DEQUEUE
endif

ifeq ($(BOARD_USE_MHEAP_SCREENSHOT),true)
    LOCAL_CFLAGS += -DUSE_MHEAP_SCREENSHOT
endif

LOCAL_MODULE:= libgui

ifeq ($(TARGET_BOARD_PLATFORM), tegra)
	LOCAL_CFLAGS += -DDONT_USE_FENCE_SYNC
endif
ifeq ($(TARGET_BOARD_PLATFORM), tegra3)
	LOCAL_CFLAGS += -DDONT_USE_FENCE_SYNC
endif

include $(BUILD_SHARED_LIBRARY)

ifeq (,$(ONE_SHOT_MAKEFILE))
include $(call first-makefiles-under,$(LOCAL_PATH))
endif
