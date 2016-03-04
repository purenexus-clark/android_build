# Target-specific configuration

define bt-vendor-set-path-variant
$(call project-set-path-variant,bt-vendor,TARGET_BT_VENDOR_VARIANT,hardware/qcom/$(1))
endef

# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef


ifeq ($(BOARD_USES_QCOM_HARDWARE),true)

    COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE
    COMMON_GLOBAL_CPPFLAGS += -DQCOM_HARDWARE

    ifeq ($(TARGET_USES_QCOM_BSP),true)
        COMMON_GLOBAL_CFLAGS += -DQCOM_BSP -DQTI_BSP
        COMMON_GLOBAL_CPPFLAGS += -DQCOM_BSP -DQTI_BSP
    endif
$(call bt-vendor-set-path-variant,bt-caf)
else
$(call bt-vendor-set-path-variant,bt)
endif

