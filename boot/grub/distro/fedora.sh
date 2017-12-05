set icon="fedora";
set vmlinuz_img="(loop)/isolinux/vmlinuz*";
set initrd_img="(loop)/isolinux/initrd*";
if test -f (loop)/boot/vmlinuz -a -f (loop)/boot/initrd; then
	vmlinuz_img=(loop)/boot/vmlinuz;
	initrd_img=(loop)/boot/initrd;
elif test -f (loop)/boot/vmlinuz* -a -f (loop)/boot/liveinitrd*; then
	# OpenMandriva
	linux_extra="root=live:LABEL=${iso_label} iso-scan/filename=${iso_path}"
	vmlinuz_img=(loop)/boot/vmlinuz*;
	initrd_img=(loop)/boot/liveinitrd*;
fi;
if test -f $vmlinuz_img -a -d (loop)/LiveOS; then
	menuentry $"Fedora Live" --class $icon{
		set kcmdline="rd.live.image";
		linux $vmlinuz_img $kcmdline $linux_extra;
		initrd $initrd_img;
	}
	menuentry $"Fedora Live Fail Safe" --class $icon{
		set kcmdline="rd.live.image nomodeset";
		linux $vmlinuz_img $kcmdline $linux_extra;
		initrd $initrd_img;
	}
	menuentry $"Fedora Live Rescue" --class $icon{
		set kcmdline="rd.live.image rescue";
		linux $vmlinuz_img $kcmdline $linux_extra;
		initrd $initrd_img;
	}
fi;
if test -f (loop)/images/pxeboot/vmlinuz*; then
	menuentry $"Fedora Minimal Install" --class $icon{
		linux (loop)/images/pxeboot/vmlinuz* boot=images quiet iso-scan/filename="$iso_path" inst.stage2=hd:UUID="$iso_uuid";
		initrd (loop)/images/pxeboot/initrd*;
	}
fi;