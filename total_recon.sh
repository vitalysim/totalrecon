#!/bin/bash
show_menus() {
	clear
        echo -e "${GREEN}\

#######                            ######                              
   #     ####  #####   ##   #      #     # ######  ####   ####  #    # 
   #    #    #   #    #  #  #      #     # #      #    # #    # ##   # 
   #    #    #   #   #    # #      ######  #####  #      #    # # #  # 
   #    #    #   #   ###### #      #   #   #      #      #    # #  # # 
   #    #    #   #   #    # #      #    #  #      #    # #    # #   ## 
   #     ####    #   #    # ###### #     # ######  ####   ####  #    # 
                                                                       

        ${SET}"
    echo -e "${CYAN}TotalRecon will install all the recon tools you need${SET}"
    echo "Tools:"
    echo "   0. Install dependencis [GO, Python3, Ruby, Rust, Chromium, etc]"
	echo "   1. Fast web fuzzer (ffuf)"
	echo "   2. Dirsearch"
	echo "   3. Findomain"
	echo "   4. Httprobe"
	echo "   5. Masscan"
	echo "   6. Nmap"
	echo "   7. Sublist3r"
	echo "   8. WhatWeb"
	echo "   9. Subjack"
	echo "  10. Amass"
	echo -e "\n\n  88. Install all tools"
	echo -e "  99. Exit\n"
}

read_option(){
	local choice
	read -p "Enter choice [ 1 - 99] " choice
	case $choice in
        0) install_dependencis ;;
		1) install_ffuf ;;
		2) install_dirsearch ;;
		3) install_findomain ;;
		4) install_httprobe ;;
		5) install_masscan ;;
		6) install_nmap ;;
		7) install_sublist3r ;;
		8) install_whatweb ;;
		9) install_subjack ;;
		10) install_amass ;;
        88) install_all ;;
		99) exit 0;;
		*) echo -e "${RED}Error...${SET}" && sleep 2
	esac
}

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
 
load_colors() {
    # https://www.shellhacks.com/bash-colors/
    DARKGRAY='\033[1;30m'
    RED='\033[0;31m'    
    LIGHTRED='\033[1;31m'
    GREEN='\033[0;32m'    
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'    
    PURPLE='\033[0;35m'    
    LIGHTPURPLE='\033[1;35m'
    CYAN='\033[0;36m'    
    WHITE='\033[1;37m'
    SET='\033[0m'
}

install_dependencis() {
    echo -e "${GREEN}Installing tool's dependencis ${SET}"
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get update && sudo apt-get -y upgrade
    sudo apt-get install -y golang-go build-essential python3 python3-dev wget unzip chromium-browser gcc make libpcap-dev python3-pip ruby-full
    sudo ln -s /usr/bin/python3 /usr/bin/python
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env
    echo -e "${YELLOW}Finished installing tool's dependencis ${SET}\n"
    pause
}

install_ffuf() {
    # https://github.com/ffuf/ffuf
    echo -e "${GREEN}Installing Fast web fuzzer (ffuf) ${SET}"
    go get -u github.com/ffuf/ffuf
    sudo cp $HOME/go/bin/ffuf /usr/local/bin
    echo -e "${YELLOW}Finished installing Fast web fuzzer (ffuf) ${SET}\n"
    pause
}

install_findomain() {
    # https://github.com/Edu4rdSHL/findomain
    echo -e "${GREEN}Installing findomain ${SET}"
    git clone https://github.com/Edu4rdSHL/findomain.git $HOME/tools/findomain
    cd $HOME/tools/findomain && cargo build --release && sudo cp $HOME/tools/findomain/target/release/findomain /usr/local/bin
    sudo rm -r $HOME/tools/findomain
    echo -e "${YELLOW}Finished installing findomain ${SET}\n"
    pause

}


install_dirsearch() {
    echo -e "${GREEN}Installing dirsearch ${SET}"
    git clone https://github.com/maurosoria/dirsearch.git $HOME/tools/dirsearch
    if [[ ":$PATH:" == *":$HOME/tools/dirsearch:"* ]]; then
        echo "Dirsearch dir already in path"
    else
        echo "export PATH=$PATH:$HOME/tools/dirsearch" >> $HOME/.bash_profile && source $HOME/.bash_profile
    fi
    ln -sf $HOME/tools/dirsearch/dirsearch.py $HOME/tools/dirsearch/dirsearch && chmod +x $HOME/tools/dirsearch/dirsearch
    echo -e "${YELLOW}Finished installing dirsearch ${SET}\n"
    pause
}

install_aquatone() {
    # https://github.com/michenriksen/aquatone
    echo -e "${GREEN}Installing aquatone ${SET}"
    wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip -O $HOME/tools/aquatone.zip
    cd $HOME/tools && unzip aquatone.zip -d $HOME/tools/aquatone && sudo cp $HOME/tools/aquatone/aquatone /usr/local/bin
    sudo rm -r $HOME/tools/aquatone && rm $HOME/tools/aquatone.zip
    echo -e "${YELLOW}Finished installing aquatone ${SET}\n"
    pause
}

install_httprobe() {
    # https://github.com/tomnomnom/httprobe
    echo -e "${GREEN}Installing httprobe ${SET}"
    go get -u github.com/tomnomnom/httprobe
    sudo cp $HOME/go/bin/httprobe /usr/local/bin
    echo -e "${YELLOW}Finished installing httprobe ${SET}\n"
    pause

}

install_masscan() {
    # https://github.com/robertdavidgraham/masscan
    echo -e "${GREEN}Installing masscan ${SET}"
    git clone https://github.com/robertdavidgraham/masscan $HOME/tools/masscan
    cd $HOME/tools/masscan && make -j && sudo cp $HOME/tools/masscan/bin/masscan /usr/local/bin
    sudo rm -r $HOME/tools/masscan
    echo -e "${YELLOW}Finished installing masscan ${SET}\n"
    pause
}


install_sublist3r() {
    # https://github.com/aboul3la/Sublist3r
    echo -e "${GREEN}Installing sublist3r ${SET}"
    git clone https://github.com/aboul3la/Sublist3r.git $HOME/tools/sublist3r
    pip3 install --no-cache-dir --install-option="--prefix=/install" -r $HOME/tools/sublist3r/requirements.txt
    if [[ ":$PATH:" == *":$HOME/tools/sublist3r:"* ]]; then
        echo "Sublist3r dir already in path"
    else
        echo "export PATH=$PATH:$HOME/tools/sublist3r" >> $HOME/.bash_profile && source $HOME/.bash_profile
    fi
    ln -sf $HOME/tools/sublist3r/sublist3r.py $HOME/tools/sublist3r/sublist3r && chmod +x $HOME/tools/sublist3r/sublist3r
    echo -e "${YELLOW}Finished installing sublist3r ${SET}\n"
    pause
}

install_whatweb() {
    # https://github.com/urbanadventurer/WhatWeb
    echo -e "${GREEN}Installing WhatWeb ${SET}"
    git clone https://github.com/urbanadventurer/WhatWeb.git $HOME/tools/whatweb
    cd $HOME/tools/whatweb && sudo gem install bundler && bundle install
    if [[ ":$PATH:" == *":$HOME/tools/whatweb:"* ]]; then
        echo "Whatweb dir already in path"
    else
        echo "export PATH=$PATH:$HOME/tools/whatweb" >> $HOME/.bash_profile && source $HOME/.bash_profile
    fi
    
    echo -e "${YELLOW}Finished installing WhatWeb ${SET}\n"
    pause

}

install_subjack() {
    # https://github.com/haccer/subjack
    echo -e "${GREEN}Installing Subjack ${SET}"
    go get github.com/haccer/subjack
    sudo cp $HOME/go/bin/subjack /usr/local/bin
    echo -e "${YELLOW}Finished installing Subjack ${SET}\n"
    pause
}

install_amass() {
    # https://github.com/OWASP/Amass
    echo -e "${GREEN}Installing Amass ${SET}"
    go get -u github.com/OWASP/Amass/...
    sudo cp $HOME/go/bin/amass /usr/local/bin
    echo -e "${YELLOW}Finished installing Amass ${SET}\n"
    pause
}

install_nmap() {
    # https://github.com/OWASP/Amass
    echo -e "${GREEN}Installing Nmap ${SET}"
    sudo apt-get install -y nmap
    echo -e "${YELLOW}Finished installing Nmap ${SET}\n"
    pause
}

install_all () {
    install_ffuf
    install_findomain
    install_dirsearch
    install_aquatone
    install_httprobe
    install_masscan
    install_sublist3r
    install_whatweb
    install_subjack
    install_amass
    install_nmap
    pause
}

trap '' SIGINT SIGQUIT SIGTSTP

while true
do
	load_colors
    show_menus
    read_option
done

