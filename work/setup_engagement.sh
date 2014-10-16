#!/usr/bin/env bash

function me(){
  # local variables
  local engagement_path=$HOME/engagements/$1
  local tools_path=$HOME/tools

  if [ -f $engagement_path ]; then
    echo "Error: The $CYAN ${1} project already exists"
    return 1
  fi

  if [ -d $engagement_path ]; then
    echo "Error: The $CYAN ${1} project already exists"
    return 1
  fi

  mkdir $engagement_path/
  mkdir $engagement_path/config
  mkdir $engagement_path/output
  mkdir $engagement_path/src
  mkdir $engagement_path/bin
  
  cp -R $HOME/Documents/templates/WAPT_Methodology_v1.5.1.numbers $engagement_path/WAPT_Methodology_v1.5.1.numbers
  cd $engagement_path
  mv WAPT_Methodology_v1.5.1.numbers wapt-$1.numbers 

  # update various tools and copy configs
  cd $tools_path/sqlmap_dev
  echo -e "Updating sqlmap ...\n"
  /usr/local/bin/python sqlmap.py --update
  cp sqlmap.conf $engagement_path/config/sqlmap_$1.conf

  cd $tools_path/nikto-2.1.5
  echo ""
  echo -e "Updating nikto ...\n"
  /usr/bin/perl nikto.pl --update
  cp nikto.conf $engagement_path/config/nikto_$1.conf

  cd $tools_path
  echo ""
  echo "Updating: testssl ..."
  cd testssl.sh
  git pull origin master
  
  echo "#!/usr/local/bin/bash" > $HOME/.dotfiles/.engagement
  echo "export ENGAGEMENT=$engagement_path/bin" >> $HOME/.dotfiles/.engagement
  
  
  export ENGAGEMENT="$engagement_path/bin"
  export PATH="$ENGAGEMENT:$PATH"
  

  #copy scripts over for tools
  cd $HOME/tools/burp
  cp scripts/sb $ENGAGEMENT/sb
  cp scripts/ff $ENGAGEMENT/ff
  cd $ENGAGEMENT

  # Sqlmap config
  echo "#!/usr/local/bin/bash" > sqlmap
  echo "PARAMS=("\$@")" >> sqlmap
  echo "declare -a NEWPARAMS" >> sqlmap
  echo "for ((i=1; i <= \$#-1; i++)); do NEWPARAMS=( "\${NEWPARAMS[@]}" "\${PARAMS[\$i]}" ); done;" >> sqlmap
  echo "if [ \$1 ]; then" >> sqlmap
  echo "  /usr/local/bin/python $tools_path/sqlmap-dev/sqlmap.py -c $engagement_path/config/sqlmap_$i.conf -u \$1 \${NEWPARAMS[@]}" >> sqlmap
  echo "else" >> sqlmap
  echo "/usr/local/bin/python $tools_path/sqlmap-dev/sqlmap.py -c $engagement_path/config/sqlmap_$i.conf \$@" >> sqlmap
  echo "fi" >> sqlmap
  chmod 700 sqlmap


  # Nikto configuration
  echo "#!/usr/local/bin/bash" > nikto

  echo "if [ -z $1 ];then" >> nikto
  echo "  echo "Error: No Hostname"" >> nikto
  echo "  exit" >> nikto
  echo "fi" >> nikto

  echo "HOSTNAME=\`echo \$1 | awk -F/ '{print \$3}'\`" >> nikto
  echo "PROTOCOL=\`echo \$1 | awk -F/ '{print \$1}'\`" >> nikto
  echo "PARAMS=("\$@")" >> nikto
  echo "declare -a NEWPARAMS" >> nikto
  echo "for ((i=1; i <= \$#-1; i++)); do NEWPARAMS=( "\${NEWPARAMS[@]}" "\${PARAMS[\$i]}" ); done;" >> nikto
  echo "if [ "\$1" = "https:" ]; then" >> nikto
  echo "  perl $tools_path/nikto-2.1.5/nikto.pl -useproxy -config $engagement_path/config/nikto_$i.conf -Format htm -host \$HOSTNAME -port 443 -output $engagement_path/output/\$HOSTNAME.htm -ssl -vhost \$HOSTNAME -useproxy https://localhost:8080 \${NEWPARAMS[@]}" >> nikto
  echo "fi" >> nikto
  echo "perl $tools_path/nikto-2.1.5/nikto.pl -useproxy -config $engagement_path/config/nikto_$i.conf -Format htm -host \$HOSTNAME -port 80 -output $engagement_path/output/\$HOSTNAME.htm -vhost \$HOSTNAME -useproxy http://localhost:8080 \${NEWPARAMS[@]}" >> nikto
  chmod 700 nikto

  # TestSSL 
  echo "" > testssl.sh
  echo "PARAMS=("\$@")" >> testssl.sh
  echo "declare -a NEWPARAMS" >> testssl.sh
  echo "for ((i=1; i <= $#-1; i++)); do NEWPARAMS=( "\${NEWPARAMS[@]}" "\${PARAMS[$i]}" ); done;" >> testssl.sh
  echo "#!/usr/local/bin/bash" >> testssl.sh
  echo "export OPENSSL=/usr/local/Cellar/openssl/1.0.1i/bin/openssl" >> testssl.sh
  echo "$tools_path/testssl.sh/testssl.sh \$1 ${NEWPARAMS[@]}" >> testssl.sh
  chmod 700 testssl.sh


  echo -e "\nProject created: $ORANGE $1"
  cd $engagement_path
}
