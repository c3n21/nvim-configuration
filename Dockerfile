FROM archlinux:base-devel
SHELL ["/bin/bash", "-c"]
WORKDIR setup
RUN pacman -Sy
RUN pacman -S git --noconfirm
RUN curl -OL https://raw.githubusercontent.com/norcalli/bot-ci/master/scripts/github-actions-setup.sh
RUN source github-actions-setup.sh nightly_x64
WORKDIR /root/.config/nvim
COPY . ./
ENTRYPOINT /setup/_neovim/bin/nvim
