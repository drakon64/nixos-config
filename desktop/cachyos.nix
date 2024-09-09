{ lib, pkgs, ... }:

let
  cachyPatches = pkgs.fetchFromGitHub {
    owner = "CachyOS";
    repo = "kernel-patches";
    rev = "a728b84eba6c5012b027aaf9c2085ea256e85693";
    hash = "sha256-QytyBu+TCVM9QqGbYaMrkOaHVWOKuYz9AEAc3BPx3gY=";
  };

  kernelVersion = "6.10";
in
{
  boot.kernelPatches = [
    {
      name = "amd-pstate";
      patch = "${cachyPatches}/${kernelVersion}/0001-amd-pstate.patch";
    }
    {
      name = "bbr3";
      patch = "${cachyPatches}/${kernelVersion}/0002-bbr3.patch";

      extraStructuredConfig = with lib.kernel; {
        TCP_CONG_CUBIC = lib.mkOverride 60 module;
        TCP_CONG_BBR = yes;
        DEFAULT_BBR = yes;
        DEFAULT_TCP_CONG = freeform "bbr";
      };
    }
    {
      name = "block";
      patch = "${cachyPatches}/${kernelVersion}/0003-block.patch";
    }
    {
      name = "cachy";
      patch = "${cachyPatches}/${kernelVersion}/0004-cachy.patch";

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

        TRANSPARENT_HUGEPAGE_MADVISE = lib.mkOverride 60 no;
        TRANSPARENT_HUGEPAGE_ALWAYS = lib.mkOverride 60 yes;

        USER_NS = yes;
      };
    }
    {
      name = "crypto";
      patch = "${cachyPatches}/${kernelVersion}/0005-crypto.patch";
    }
    {
      name = "fixes";
      patch = "${cachyPatches}/${kernelVersion}/0006-fixes.patch";
    }
    {
      name = "ksm";
      patch = "${cachyPatches}/${kernelVersion}/0008-ksm.patch";
    }
    #{
    #  name = "ntsync";
    #  patch = "${cachyPatches}/${kernelVersion}/0009-ntsync.patch";

    #  extraStructuredConfig = with lib.kernel; {
    #    NTSYNC = yes;
    #  };
    #}
    {
      name = "perf-per-core";
      patch = "${cachyPatches}/${kernelVersion}/0010-perf-per-core.patch";
    }
    {
      name = "zstd";
      patch = "${cachyPatches}/${kernelVersion}/0012-zstd.patch";
    }
    {
      name = "bore-cachy";
      patch = "${cachyPatches}/${kernelVersion}/sched/0001-bore-cachy.patch";

      extraStructuredConfig = with lib.kernel; {
        SCHED_BORE = yes;
        MIN_BASE_SLICE_NS = freeform "1000000";
      };
    }
  ];
}
