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

        NUMA = lib.mkForce no;
        NUMA_BALANCING = lib.mkForce no;

        INFINIBAND = lib.mkForce no;
        INFINIBAND_IPOIB = lib.mkForce no;
        INFINIBAND_IPOIB_CM = lib.mkForce no;

        X86_SGX = lib.mkForce false;

        XEN = lib.mkForce no;

        ACPI_HOTPLUG_CPU = lib.mkForce no;
        ACPI_HOTPLUG_MEMORY = lib.mkForce no;
        MEMORY_HOTPLUG = lib.mkForce no;
        MEMORY_HOTREMOVE = lib.mkForce no;
        HOTPLUG_CPU = lib.mkForce no;
        MIGRATION = lib.mkForce no;
        SPARSEMEM = lib.mkForce no;

        NR_CPUS = lib.mkForce (freeform "16");

        INTEL_TURBO_MAX_3 = lib.mkForce false;
      };
    }
  ];
}
