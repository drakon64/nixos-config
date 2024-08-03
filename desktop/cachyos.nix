{ lib, pkgs, ... }:

let
  kernelVersion = "6.10";
  cachyRev = "3ef9d17d64f2a195405e8fb840542667bd5b8026";
in
{
  boot.kernelPatches = [
    {
      name = "amd-pstate";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/0001-amd-pstate.patch";
          hash = "sha256-Ur5b+ao+n9UuNR/M2qeZ/pEkMS3pt0Tz7ZwRYh4DiGk=";
        }
      );
    }
    {
      name = "bbr3";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/0002-bbr3.patch";
          hash = "sha256-sfZNjbRRWr1SSkgeAND2P4av9orOIcOOVUfgmaR9/sI=";
        }
      );

      extraStructuredConfig = {
        TCP_CONG_CUBIC = lib.mkOverride 60 module;
        TCP_CONG_BBR = yes;
        DEFAULT_BBR = yes;
        DEFAULT_TCP_CONG = freeform "bbr";
      };
    }
    {
      name = "block";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/0003-block.patch";
          hash = "sha256-uMzWrAr2fKbMY6Hxu9L35ziCk65wJM0CGRSMU6zAHd0=";
        }
      );
    }
    {
      name = "cachy";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/0004-cachy.patch";
          hash = "sha256-tu1R0TsHXUcOBr+uLJ3G0Cbhau9qdNhWBorZA5wxWIg=";
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

        TRANSPARENT_HUGEPAGE_MADVISE = lib.mkOverride 60 no;
        TRANSPARENT_HUGEPAGE_ALWAYS = lib.mkOverride 60 yes;

        USER_NS = yes;
      };
    }
    {
      name = "crypto";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0005-crypto.patch";
          hash = "sha256-fUoCgaS1Y5vRvxGDHT7mAE2uwO+b88j/HhCRs6s//tA=";
        }
      );
    }
    {
      name = "fixes";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0006-fixes.patch";
          hash = "sha256-ows07gI4T2FYTmRXq9AObnxChYsOa+AwidxHqzKnGCg=";
        }
      );
    }
    {
      name = "ksm";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0008-ksm.patch";
          hash = "sha256-l1uj1zPrVGhf31W6BSbpEYCfvu/w/jt0YqbJyvthAD0=";
        }
      );
    }
    #{
    #  name = "ntsync";
    #  patch = (
    #    pkgs.fetchurl {
    #      url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0009-ntsync.patch";
    #      hash = "sha256-n2OMEK2ZwdOZJTA9qMBAEnQC5sx4cClWZObN/oCGi2U=";
    #    }
    #  );

    #  extraStructuredConfig = with lib.kernel; {
    #    NTSYNC = yes;
    #  };
    #}
    {
      name = "perf-per-core";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0010-perf-per-core.patch";
          hash = "sha256-anDxoS/GnjLLmoFnNt6iDKyXVeDPBe49dR8tBR1J4Wg=";
        }
      );
    }
    {
      name = "zstd";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0012-zstd.patch";
          hash = "sha256-miI8Y9fAhZbNLUfSS7dC23BTVD8Z4JXbRyCQAi2ZP+w=";
        }
      );
    }
    {
      name = "bore-cachy";
      patch = (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyRev}/${kernelVersion}/sched/0001-bore-cachy.patch";
          hash = "sha256-5ypFKznJg5tig4DMVC90lK0kkqaJSGIx01QDiz/V/po=";
        }
      );

      extraStructuredConfig = with lib.kernel; {
        SCHED_BORE = yes;
        MIN_BASE_SLICE_NS = freeform "1000000";
      };
    }
  ];
}
