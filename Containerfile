FROM quay.io/fedora/fedora-bootc:40

run dnf install -y alsa-sof-firmware alsa-ucm alsa-utils wireplumber alsa-utils pipewire pipewire-alsa alsa-utils cargo

run dnf -y install glibc-langpack-en glibc-all-langpacks
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

run dnf -y install strace

run dnf install -y 'dnf-command(copr)'

# TODO For some reason the copr command wasn't working well with podman build.
add _copr:copr.fedorainfracloud.org:ycollet:audinux.repo /etc/yum.repos.d
run dnf install -y pipewire-jack-audio-connection-kit-libs pipewire-utils tmux vim realTimeConfigQuickScan 
add sonic-pi.spec /root
workdir /root
run dnf builddep -y sonic-pi.spec
add gai.conf /etc/
run gem install prime

# I may switch this to cloning the git repo instead of working from my local
# source. Do what you want here.
copy sonic-pi /root/
run dnf install -y git wayland-devel libxkbcommon-devel libXext-devel vcpkg libatomic elixir coreutils
run app/linux-build-all.sh 2>&1 | tee sonic-pi-build_out.txt

#run dnf groupinstall -y "Fedora Workstation"
#run dnf install -y gdm
#run systemctl enable gdm.service --force
#run systemctl set-default graphical.target


# trying to use rtmidi from the system so I had to run the config script which needed this library.
#run dnf install -y libsndfile libsndfile-devel

entrypoint pw-jack /root/bin/sonic-pi-repl.sh
#run dnf copr enable -y ycollet/audinux
