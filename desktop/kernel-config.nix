{ lib, ... }:

{
  boot.kernelPatches = [
    {
      name = "config";
      patch = null;

      extraStructuredConfig = with lib.kernel; {
        CEPH_FS = no;
        CEPH_FSCACHE = lib.mkForce unset;
        CEPH_FS_POSIX_ACL = lib.mkForce unset;

        CHROME_PLATFORMS = lib.mkForce no;
        CHROMEOS_LAPTOP = lib.mkForce unset;
        CHROMEOS_PSTORE = lib.mkForce unset;
        CHROMEOS_TBMC = lib.mkForce unset;
        CROS_EC = lib.mkForce unset;
        CROS_EC_I2C = lib.mkForce unset;
        CROS_EC_ISHTP = lib.mkForce unset;
        CROS_EC_LPC = lib.mkForce unset;
        CROS_EC_SPI = lib.mkForce unset;
        CROS_KBD_LED_BACKLIGHT = lib.mkForce unset;

        DRM_AMDGPU = no;
        DRM_AMDGPU_CIK = lib.mkForce unset;
        DRM_AMDGPU_SI = lib.mkForce unset;
        DRM_AMDGPU_USERPTR = lib.mkForce unset;
        DRM_AMD_ACP = lib.mkForce unset;
        DRM_AMD_DC_FP = lib.mkForce unset;
        DRM_AMD_DC_SI = lib.mkForce unset;
        DRM_AMD_ISP = lib.mkForce unset;
        DRM_AMD_SECURE_DISPLAY = lib.mkForce unset;
        HSA_AMD = lib.mkForce unset;

        DRM_HYPERV = lib.mkForce unset;

        DRM_NOUVEAU = no;
        DRM_NOUVEAU_GSP_DEFAULT = lib.mkForce unset;
        DRM_NOUVEAU_SVM = lib.mkForce unset;

        DRM_XE = no;
        HMM_MIRROR = lib.mkForce unset;

        FIREWIRE = no;
        FIREWIRE_NOSY = no;

        GENERIC_CPU = no;
        MZEN3 = yes;

        GNSS = no;

        HYPERVISOR_GUEST = lib.mkForce no;
        KVM_GUEST = lib.mkForce unset;
        MOUSE_PS2_VMMOUSE = lib.mkForce unset;
        PARAVIRT_TIME_ACCOUNTING = lib.mkForce unset;

        INFINIBAND = lib.mkForce no;
        INFINIBAND_IPOIB = lib.mkForce unset;
        INFINIBAND_IPOIB_CM = lib.mkForce unset;

        INPUT_TOUCHSCREEN = no;

        INPUT_JOYSTICK = no;
        JOYSTICK_PSXPAD_SPI_FF = lib.mkForce unset;

        NR_CPUS = lib.mkForce (freeform "16");

        NUMA = lib.mkForce no;
        NUMA_BALANCING = lib.mkForce unset;

        STAGING = lib.mkForce no;
      };
    }
  ];
}
