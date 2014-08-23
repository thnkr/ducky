#!/bin/bash
PS3='Builder: '
$pre = "[GOODDATA]"

echo ''
echo '====================='
echo 'GOODDATA Builder 2014'
echo '====================='
echo ''
echo 'Welcome!'
echo 'To install some of the applications we will need sudo. Enter your computer password...'
sudo rm -Rf checkroot.txt
echo '\r'
options=("Install Brew, Git, RVM, Sublime and Ruby" "Scaffold GoodData Demo Project" "Load Demo S3 Data" "Quit")
select opt in "${options[@]}"
do
    case $opt in

        "Install Brew, Git, RVM, Sublime and Ruby")
            # RVM
            echo "[GoodData] Installing RVM & Ruby"
            curl -sSL https://get.rvm.io | bash -s stable --ruby

            # Homebrew
            echo "[GoodData] Installing Homebrew..."
            ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

            # Git
            echo '[GoodData] Installing Github...'
            brew install git

            # Sublime
            echo "[GoodData] Installing Sublime Text 2..."
            curl -o sublime.dmg 'https://s3.amazonaws.com/xnh/sublime.dmg'
            hdiutil mount sublime.dmg
            sudo cp -R "/Volumes/Sublime Text 2/Sublime Text 2.app" /Applications
            rm -Rf sublime.dmg

            # Create link to Sublime Command Line Tool
            ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl

            echo "Complete!"
            ;;

        "Scaffold GoodData Demo Project")
            echo "[GoodData] Downloading Ruby SDK Builder"

            # Interactive will set up the Nitrous hack box. Not will scaffold project.
            read -p "Run interactivly? (y/n): " answer
            if [ "$answer" == y ] || [ "$answer" == "" ] || [ "$answer" == yes ] ; then
                echo '[GoodData] Downloading Ruby SDK Interactive Builder...'
                curl -o builder.rb 'https://raw.githubusercontent.com/thnkr/gooddata-ruby-box/master/builder.rb'
                echo ''
                ruby builder.rb
            else
                echo '[GoodData] Downloading Ruby SDK Interactive Builder...'
                gem install gooddata
                gooddata scaffold project my_test_project
            fi
            ;;

        "Load Demo S3 Data")
            echo "It should curl the data from S3 or something here..."
            ;;

        "Quit")
            echo "Exiting..."
            rm -Rf builder.rb
            rm -Rf sublime.dmg
            break
            ;;
        *) echo invalid option;;
    esac
done
