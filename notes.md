# grub

awk '/menuentry/ && /class/ {count++; print count-1"****"$0 }' /boot/grub/grub.cfg                                                                                                      root@calculon 18:06:58
0****menuentry 'Arch Linux' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-05be3904-0b6c-4717-a8d1-c3a091926cd9' {
1****	menuentry 'Arch Linux, with Linux linux-lts' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-linux-lts-advanced-05be3904-0b6c-4717-a8d1-c3a091926cd9' {
2****	menuentry 'Arch Linux, with Linux linux-lts (fallback initramfs)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-linux-lts-fallback-05be3904-0b6c-4717-a8d1-c3a091926cd9' {


grub-set-default 'Advanced options for Arch Linux>Arch Linux, with Linux linux-lts'

The above works because the man 8 grub-set-default page says this about MENU_ENTRY option:

MENU_ENTRY is a number, a menu item title or a menu item identifier.
