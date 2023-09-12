{
  # nix remote builders also require root accepted host key to avoid:
  # "Host key verification failed"
  # see https://github.com/NixOS/nix/issues/2030#issuecomment-1289522180
  # following is the output of: $ ssh-keyscan <host>
  environment.etc."ssh/ssh_known_hosts".text = ''
  192.168.1.149 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJNQPXmfzavdOguKet5Tp4fC5DqmLy2WLHKf3bZThkNLV4zGvAL48en/iTeEq6j07JhOf5O41slJyT3ajJ5PzP1SvPBgmo9Sp51KpIGn8reySRxh9n970HSnLZ2PLviQXmjCcja6UUdkOC/kJ5fCZ208MT0nLfSyIdTuj8/U8E0l+X8omh02Plc25XMUTwusGMc8UHj2pzzixz2Jo07+nmu/my7mdCMBGXr7/+g/0/MVW6EdoHtbivVonJcn6q77beEuUiw/siUtafu0wcyoF0kIQ4y3jvaWLykwJoCPpvYz0gutaA+5GvH5TgU8ssKMClZvRbUEnD2gcWNYdSPieqIyo9ehvM9jMzIY8pQ+kjQH0ZA56WULX1Bp1z9T0yqqbNvsfg/irSfnhzBn4KgoRLJPd+G5r2pxVdHjaX12x2wDrjbpvKbB7+AzbqeeAt0TEJcvEaooTvua6U0k7sMr4MGj628eTyoO5ZgGqLVYLP7esK1/VYNJt4L9y2tBJgJ85+lMwqctQXdrfa4KxfqypR9rJ2erAhwj+pUqYuIxar+3wynddp/vhH6YYks//N/2QWYe+pDv+NWfiXsV3zIL1F2L/lRuCGIsdpv5OcrOTbDOYaZyq3sek0ymwUDOCt9vwU1i57X8qoq9DozOgn9YmmC7Z4ZvZ4q4uCPB/w6vD8sw==
  192.168.1.149 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPK1VmVasHa7U86AEJZkIt8il0xI9CFZ4t+bClJyOYmv
  '';
}
