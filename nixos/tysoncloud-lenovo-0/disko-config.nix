{ ... }:
{
  disko.devices = {
    disk = {
      my-disk = {
        # Check with `lsblk` on the laptop; NVMe drives show up as /dev/nvme0n1.
        # Prefer a stable /dev/disk/by-id/... path once known.
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
