{ lib, pkgs, ... }:

let
  kernelVersion = "6.10";
  cachyRev = "f036a67118ed302c3611e82e0234f8d4279079af";
in
{
  boot.kernelPatches = [
    {
      name = "cachyos-base-all";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/all/0001-cachyos-base-all.patch";
          hash = "sha256-lZbElRTvhc6u6rEQAbpdRSPLUj/rPTqKX1ZFdMTMZlo=";
        }
      );

      extraStructuredConfig = with lib.kernel; {
        CACHY = yes;

        LTO_NONE = yes;

        HZ_300 = no;
        HZ_1000 = yes;
        HZ = freeform "1000";

        NR_CPUS = lib.mkOverride 60 (freeform "320");

        HZ_PERIODIC = no;
        NO_HZ_IDLE = no;
        NO_HZ_FULL = yes;
        NO_HZ = yes;
        NO_HZ_COMMON = yes;
        CONTEXT_TRACKING = yes;

        PREEMPT_BUILD = yes;
        PREEMPT_NONE = no;
        PREEMPT_VOLUNTARY = lib.mkOverride 60 no;
        PREEMPT = lib.mkOverride 60 yes;
        PREEMPT_COUNT = yes;
        PREEMPTION = yes;
        PREEMPT_DYNAMIC = yes;

        CC_OPTIMIZE_FOR_PERFORMANCE = no;
        CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;

        TCP_CONG_CUBIC = lib.mkOverride 60 module;
        TCP_CONG_BBR = yes;
        DEFAULT_BBR = yes;
        DEFAULT_TCP_CONG = freeform "bbr";

        TRANSPARENT_HUGEPAGE_MADVISE = lib.mkOverride 60 no;
        TRANSPARENT_HUGEPAGE_ALWAYS = lib.mkOverride 60 yes;

        USER_NS = yes;
      };
    }
    {
      name = "bore-cachy";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0001-bore-cachy.patch";
          hash = "sha256-qSRPWTMsRigTQpaEWP6shrlIfkaeRz/Lm/XgWYBQwbE=";
        }
      );

      extraStructuredConfig = with lib.kernel; {
        SCHED_BORE = yes;
        MIN_BASE_SLICE_NS = freeform "1000000";
      };
    }
  ];
}
