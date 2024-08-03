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

        NR_CPUS = lib.mkForce (freeform "16");

        NUMA = lib.mkForce no;
        NUMA_BALANCING = lib.mkForce no;
      };
    }
  ];
}
