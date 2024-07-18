(use-modules (gnu))
(use-service-modules networking ssh)
(use-package-modules certs screen)

(operating-system
 (host-name "guix")
 (timezone "America/hne")
 (locale "es_CO.utf8")
 (keyboard-layout (keyboard-layout "latam" "nodeadkeys"))
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (target (list "/boot/efi"))
              (keyboard-layout keyboard-layout)))
 (file-systems (cons (file-system
                       (device ("/dev/sda1"))
                       (mount-point "/boot/efi")
                       (type "vfat"))
                      (file-system
                       (device ("/dev/sda2"))
                       (mount-point "/")
                       (type "ext4"))
                     %base-file-systems))
 (users (cons (user-account
               (name "bob")
               (group "users")
               (supplementary-groups '("wheel" "audio" "video")))
              %base-user-accounts))
 (packages (append (list screen nss-certs network-manager)
                   %base-packages))
 (services (append (list (service network-manager-service-type)
                         (service openssh-service-type
                                  (openssh-configuration
                                   (port-number 2222))))
                   %base-services)))