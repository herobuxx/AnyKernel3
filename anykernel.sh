# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=LunaticKernel by HeroBuxx
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=tulip
device.name2=twolip
device.name3=wayne
device.name4=whyred
device.name5=lavender
device.name6=jasmine_sprout
supported.versions=9.0 - 11
supported.patchlevels=2019-01 -
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## Treble Check
is_treble=$(file_getprop /system/build.prop "ro.treble.enabled");
if [ ! "$is_treble" -o "$is_treble" == "false" ]; then
  ui_print " ";
  ui_print "ViviaKernel only supports Treble ROMS!";
  exit 1;
fi;

## AnyKernel install
dump_boot;

# begin ramdisk changes
# init.rc
insert_line init.rc "import /init.ptessf.rc" after "import /init.trace.rc" "import /init.pressf.rc";
# end ramdisk changes

write_boot;
## end install
