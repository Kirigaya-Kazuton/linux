#!/bin/bash

menu ()
{

clear

echo "  _____________________________________"
echo
echo "      CALCULADORA CONTA FÁCIL"
echo "           Versão 0.1"
echo "         Desenvolvido por"
echo "  _____________________________________"
echo
echo
echo "< 1 > local "
echo "< 2 > remoto "
echo "< 0 > Sair "
echo
echo "Escolha uma das opções acima:  "
read  opcao

case $opcao in
    1) local ;;
    2) remoto ;;
    0) exit ;;
esac

}

local ()
{
  clear && echo -e "Backup local \n" && tput sgr0
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  rsync -avh --progress 
  "$dir_origem" 
  "$dir_destino" 
  --log-file="$ARQUIVO_LOG" 
  # Alterar as opções se necessário
  Verifica_status

echo
echo "--------------------------------"
echo

    echo "O que deseja fazer agora?"
    echo "< m >  Menu Principal"
    echo "< s >  Sair"

    echo "Escolha uma opção"
    read op

    if [ "$op" = "m" ]
    then
        menu
    elif [ "$op" = "s" ]
    then
        clear
        exit
    else
        echo " Opção Inválida! "
    fi

}

remoto ()
{

  clear && echo -e "${Yellow}Backup remoto \n" && tput sgr0
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  sudo rsync -avhP --progress -e ssh 
  "$dir_origem" 
  "$dir_destino" 
  --log-file="$ARQUIVO_LOG" 
  # Alterar as opções se necessário
  Verifica_status
}

echo
echo "--------------------------------"
echo

    echo "O que deseja fazer agora?"
    echo "< c > Continuar"
    echo "< m >  Menu Principal"
    echo "< s >  Sair"

    echo "Escolha uma opção"
    read op

    if [ "$op" = "m" ]
    then
        menu
    elif [ "$op" = "s" ]
    then
        clear
        exit
    else
        echo " Opção Inválida! "
    fi

}
Verifica_status () {
  tail -1 "$ARQUIVO_LOG" | grep "rsync error" 
  if [ ! $? -eq 0 ]; then
    echo -e "\n${Green}Backup concluído com sucesso. \n" && tput sgr0 && exit 0
  else
    echo -e "\n${Red}Backup concluído com erros. Erros mais comuns: \n
    - Nome do arquivo e/ou diretório incorretos
    - Arquivos ou diretório inexistentes
    - Diretório está vazio 
    - Nomes compostos sem * entre as palavras. Ex: /Área*de*Trabalho
    " && tput sgr0 && exit 1
  fi
}   
# ------------------------------------------------- EXECUÇÃO ------------------------------------------------ #
echo -e "\n Backup com rsync \n $MENU" 
while test -n "$1"; do
  case "$1" in
    -l)
        clear && echo -e "${Yellow}Backup local \n" && tput sgr0 
        read -rp "Informe a origem: " dir_origem
        #Exemplo: /home/user/nome*composto
        echo -e "\nOs arquivos serão salvos em /home/$USER/Backup/ \n"
        echo "Deseja manter esse diretório de destino? [s/n] "
        read -rn1 resposta && echo ""
        case "$resposta" in
          S | s) dir_destino="/home/$USER/Backup/" && Backup_local ;; 
          N | n) read -rp "Digite o diretório de destino: " dir_destino && Backup_local ;; 
              *) echo "Processo abortado." && exit 1 ;;
        esac
    ;;
    -r) 
        clear && echo -e "${Yellow}Backup remoto \n" && tput sgr0
        read -rp "Digite a origem (Exemplo:/home/$USER/Backup/): " dir_origem && echo ""  
        read -rp "Digite o destino (Exemplo: username@xxx.xxx.xxx:~/destino): " dir_destino && echo ""
        Backup_remoto
    ;;
     *) echo -e "${Red}Opção inválida. Digite $0 [-Opção] \n" && tput sgr0
        exit 1
    ;;
  esac
done


################### CHAMAR O MENU PRINCIPAL ###################


menu

##############################################################
