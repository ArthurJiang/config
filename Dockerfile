FROM ubuntu:latest

RUN apt-get update && apt-get install -y software-properties-common
# RUN apt-get install -y emacs && apt-get install -y git
RUN add-apt-repository ppa:kelleyk/emacs && apt-get update && apt-get install -y emacs25 && apt-get install -y git
# RUN add-apt-repository ppa:cassou/emacs && apt-get update && apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg && apt-get install -y git
RUN apt-get install -y wget && apt-get install -y curl
RUN mkdir ~/.emacs.d && git clone https://github.com/ArthurJiang/emacs.d.git  ~/.emacs.d

RUN wget https://raw.githubusercontent.com/ArthurJiang/config/master/.bashrc -O ~/.bashrc
RUN bash /root/.emacs.d/test-startup.sh
# RUN /usr/bin/emacs --load ~/.emacs.d/init.el -nw --daemon
RUN emacs --script ~/.emacs.d/init.el || echo hi


RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN mkdir ~/torch && git clone https://github.com/torch/distro.git ~/torch --recursive && cd ~/torch &&  bash install-deps && ./install.sh
RUN apt-get install -y luajit

RUN apt-get install -y python3-pip && pip3 install scikit-learn numpy scipy matplotlib ipython jupyter pandas sympy nose

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && apt-get install -y nodejs && npm install --global  mocha && npm install --global gulp-cli

RUN apt-get install -y zsh && apt-get install -y git-core
# RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || echo hi
RUN chsh -s `which zsh` && wget https://raw.githubusercontent.com/ArthurJiang/config/master/.zshrc -O ~/.zshrc

# CMD ["zsh"]