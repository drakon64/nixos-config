{ lib, ... }:

{
  boot.kernelPatches = [
    {
      name = "config";
      patch = null;

      extraStructuredConfig = with lib.kernel; {
        DRM_AMDGPU = no;

        GENERIC_CPU = no;
        MZEN3 = yes;

        X86_INTEL_PSTATE = lib.mkForce no;

        I2C = lib.mkForce no;
        I2C_DESIGNWARE_PLATFORM = lib.mkForce no;
        PMIC_OPREGION = lib.mkForce no;
        INTEL_SOC_PMIC = lib.mkForce no;
        BYTCRC_PMIC_OPREGION = lib.mkForce no;
        CHTCRC_PMIC_OPREGION = lib.mkForce no;
        XPOWER_PMIC_OPREGION = lib.mkForce no;
        BXT_WC_PMIC_OPREGION = lib.mkForce no;
        INTEL_SOC_PMIC_CHTWC = lib.mkForce no;
        CHT_WC_PMIC_OPREGION = lib.mkForce no;
        INTEL_SOC_PMIC_CHTDC_TI = lib.mkForce no;
        CHT_DC_TI_PMIC_OPREGION = lib.mkForce no;
        MFD_TPS68470 = lib.mkForce no;
        TPS68470_PMIC_OPREGION = lib.mkForce no;

        INTEL_HFI_THERMAL = lib.mkForce no;

        MEMORY_FAILURE = lib.mkForce no;

        NUMA = lib.mkForce no;
        NUMA_BALANCING = lib.mkForce no;

        INFINIBAND = lib.mkForce no;
        INFINIBAND_IPOIB = lib.mkForce no;
        INFINIBAND_IPOIB_CM = lib.mkForce no;

        DRM_I915_GVT = lib.mkForce no;
        DRM_I915_GVT_KVMGT = lib.mkForce no;
        DRM_HYPERV = lib.mkForce no;

        X86_SGX = lib.mkForce no;

        PARAVIRT = lib.mkForce no;

        HYPERVISOR_GUEST = lib.mkForce no;
        PARAVIRT_SPINLOCKS = lib.mkForce no;

        KVM_ASYNC_PF = lib.mkForce no;
        KVM_GENERIC_DIRTYLOG_READ_PROTECT = lib.mkForce no;
        KVM_GUEST = lib.mkForce no;
        KVM_MMIO = lib.mkForce no;
        KVM_VFIO = lib.mkForce no;
        KSM = lib.mkForce no;
        VIRT_DRIVERS = lib.mkForce no;

        VFIO_PCI_VGA = lib.mkForce no;

        VIRTIO_MMIO_CMDLINE_DEVICES = lib.mkForce no;

        MEDIA_DIGITAL_TV_SUPPORT = lib.mkForce no;
        MEDIA_CAMERA_SUPPORT = lib.mkForce no;
        MEDIA_ANALOG_TV_SUPPORT = lib.mkForce no;

        ZRAM = lib.mkForce no;
        ZRAM_WRITEBACK = lib.mkForce no;
        ZRAM_MULTI_COMP = lib.mkForce no;
        ZRAM_DEF_COMP_ZSTD = lib.mkForce no;
        ZSWAP = lib.mkForce no;
        ZSWAP_COMPRESSOR_DEFAULT_ZSTD = lib.mkForce no;
        ZPOOL = lib.mkForce no;
        ZSMALLOC = lib.mkForce no;

        X86_PLATFORM_DRIVERS_DELL = lib.mkForce false;
        X86_PLATFORM_DRIVERS_HP = lib.mkForce false;

        XEN = lib.mkForce no;
        XEN_DOM0 = lib.mkForce no;
        PCI_XEN = lib.mkForce no;
        HVC_XEN = lib.mkForce no;
        HVC_XEN_FRONTEND = lib.mkForce no;
        XEN_SYS_HYPERVISOR = lib.mkForce no;
        SWIOTLB_XEN = lib.mkForce no;
        XEN_BACKEND = lib.mkForce no;
        XEN_BALLOON = lib.mkForce no;
        XEN_BALLOON_MEMORY_HOTPLUG = lib.mkForce no;
        XEN_EFI = lib.mkForce no;
        XEN_HAVE_PVMMU = lib.mkForce no;
        XEN_MCE_LOG = lib.mkForce no;
        XEN_PVH = lib.mkForce no;
        XEN_PVHVM = lib.mkForce no;
        XEN_SAVE_RESTORE = lib.mkForce no;
        XEN_SELFBALLOONING = lib.mkForce no;

        ACPI_HOTPLUG_CPU = lib.mkForce no;
        ACPI_HOTPLUG_MEMORY = lib.mkForce no;
        MEMORY_HOTPLUG = lib.mkForce no;
        MEMORY_HOTREMOVE = lib.mkForce no;
        HOTPLUG_CPU = lib.mkForce no;
        MIGRATION = lib.mkForce no;
        SPARSEMEM = lib.mkForce no;

        NR_CPUS = lib.mkForce (freeform "16");

        CHROME_PLATFORMS = lib.mkForce no;
        CHROMEOS_TBMC = lib.mkForce no;

        CROS_EC = lib.mkForce no;

        CROS_EC_I2C = lib.mkForce no;
        CROS_EC_SPI = lib.mkForce no;
        CROS_EC_LPC = lib.mkForce no;
        CROS_EC_ISHTP = lib.mkForce no;

        CROS_KBD_LED_BACKLIGHT = lib.mkForce no;

        TCG_TIS_SPI_CR50 = lib.mkForce no;

        CHROMEOS_LAPTOP = lib.mkForce no;
        CHROMEOS_PSTORE = lib.mkForce no;

        X86_INTEL_TSX_MODE_AUTO = lib.mkForce no;

        INTEL_TURBO_MAX_3 = lib.mkForce no;
      };
    }
  ];
}
