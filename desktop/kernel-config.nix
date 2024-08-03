{ lib, ... }:

{
  boot.kernelPatches = [
    {
      name = "config";
      patch = null;

      extraStructuredConfig = with lib.kernel; {
        DRM_AMDGPU = no;
        DRM_AMDGPU_CIK = lib.mkForce unset;
        DRM_AMDGPU_SI = lib.mkForce unset;
        DRM_AMDGPU_USERPTR = lib.mkForce unset;
        DRM_AMD_ACP = lib.mkForce unset;
        DRM_AMD_DC_FP = lib.mkForce unset;
        DRM_AMD_DC_SI = lib.mkForce unset;
        DRM_AMD_SECURE_DISPLAY = lib.mkForce unset;
        HSA_AMD = lib.mkForce unset;

        GENERIC_CPU = no;
        MZEN3 = yes;

        NR_CPUS = lib.mkForce (freeform "16");

        NUMA = lib.mkForce no;
        NUMA_BALANCING = lib.mkForce unset;
      };
    }
  ];
}
