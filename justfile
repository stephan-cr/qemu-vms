UEFI_BIOS := "/usr/share/edk2/x64/OVMF.4m.fd"
QEMU := "qemu-system-x86_64"

default:
    just --list

freebsd:
    @exec {{QEMU}} \
    -chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on \
    -device virtio-serial-pci \
    -device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0 \
    -global isa-fdc.fdtypeA=none \
    -smp 4 \
    -nic user,model=e1000 \
    -enable-kvm \
    -m 1024 \
    -device virtio-blk,drive=myhd \
    -drive if=none,file=$HOME/freebsd.qcow2,id=myhd,index=0,media=disk

guix:
    @exec {{QEMU}} \
    -nic user,model=virtio-net-pci \
    -bios {{UEFI_BIOS}} \
    -boot menu=on,order=d \
    -enable-kvm \
    -m 2048 \
    -device virtio-blk,drive=myhd \
    -drive if=none,file=$HOME/guix.qcow2,id=myhd,index=0,media=disk
    # -drive media=cdrom,file=$HOME/Downloads/guix-system-install-1.4.0.x86_64-linux.iso

netbsd:
    @exec {{QEMU}} \
    -global isa-fdc.fdtypeA=none \
    -smp 4 \
    -nic user,model=e1000 \
    -enable-kvm \
    -m 1024 \
    -device virtio-blk,drive=myhd \
    -drive if=none,file=$HOME/netbsd.qcow2,id=myhd,index=0,media=disk
    # -drive file=$HOME/Downloads/NetBSD-9.3-amd64-install.img,index=1,media=disk,format=raw

omnios:
    @exec {{QEMU}} \
    -cpu host,-xsave \
    --bios {{UEFI_BIOS}} \
    -global isa-fdc.fdtypeA=none \
    -smp 4 \
    -nic user,model=e1000 \
    -vga virtio \
    -machine hpet=off \
    -enable-kvm \
    -m 1024 \
    -device virtio-blk,drive=myhd \
    -drive if=none,file=$HOME/openindiana.qcow2,id=myhd,index=0,media=disk
    # -drive file=$HOME/Downloads/omnios-r151054r.usb-dd,index=1,media=disk,format=raw

openbsd:
    @exec {{QEMU}} \
    -global isa-fdc.fdtypeA=none \
    --bios {{UEFI_BIOS}} \
    -smp 4 \
    -nic user,model=e1000 \
    -vga virtio \
    -enable-kvm \
    -m 1024 \
    -device virtio-blk,drive=myhd \
    -drive if=none,file=$HOME/openbsd.qcow2,id=myhd,index=0,media=disk
