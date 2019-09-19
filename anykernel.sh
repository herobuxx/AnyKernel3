# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=ViviaKernel by HeroBuxx
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=mido
device.name2=redmi note 4
device.name3=Redmi Note 4
device.name4=Redmi Note 4x
supported.versions=8.1.0 - 9
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
  ui_print "PressFKernel only supports Treble ROMS!";
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
