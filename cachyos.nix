{ lib, pkgs, ... }:

let
  cachyPatches = pkgs.fetchFromGitHub {
    owner = "CachyOS";
    repo = "kernel-patches";
    rev = "e87928a12aa8d03ad5259264818a4ed4d20dd779";
    hash = "sha256-RXj/f1H7qFwQ6XOQpa+n7hzYLyG9DbzMKnriCeBdXqk=";
  };

  kernelVersion = "6.11";
in
{
  boot.kernelPatches = [
    {
      name = "address-masking";
      patch = "${cachyPatches}/${kernelVersion}/0001-address-masking.patch";
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
      name = "cachy";
      patch = "${cachyPatches}/${kernelVersion}/0003-cachy.patch";

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
      name = "fixes";
      patch = "${cachyPatches}/${kernelVersion}/0004-fixes.patch";
    }
    {
      name = "ksm";
      patch = "${cachyPatches}/${kernelVersion}/0006-ksm.patch";
    }
    #{
    #  name = "ntsync";
    #  patch = "${cachyPatches}/${kernelVersion}/0007-ntsync.patch";

    #  extraStructuredConfig = with lib.kernel; {
    #    NTSYNC = yes;
    #  };
    #}
    {
      name = "perf-per-core";
      patch = "${cachyPatches}/${kernelVersion}/0009-perf-per-core.patch";
    }
    {
      name = "zstd";
      patch = "${cachyPatches}/${kernelVersion}/0011-zstd.patch";
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
