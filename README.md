# sonic-pi-podman
Containerfile and other things to build a sonic-pi container

# An example of how to launch it with podman on Fedora:
podman run --rm --device /dev/snd --security-opt label=type:container_runtime_t -e PIPEWIRE_RUNTIME_DIR=/tmp -v /run/user/$UID/pipewire-0:/tmp/pipewire-0:ro --tz="US/Eastern" --ulimit=host --group-add keep-groups -it quay.io/bleanhar/sonic-pi

# Use vim-slime or something similar to paste code into the sonic-pi-repl
Here's what I added to my ~/.vimrc to work well with sonic-pi's repl

```
let g:slime_target = "tmux"

function! SlimeOverride_EscapeText_ruby(text)
  " Put a comma on a new line before the text
  let result = ",\n" . a:text . "\n,\n"
  return result
endfunction
```

With that, all you have to do is run :SlimeConfig in vim then move your cursor
to a block of text and press ctl-c-c to send it to sonic-pi.
