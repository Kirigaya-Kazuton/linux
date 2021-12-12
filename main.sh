#!/bin/bash
menu ()
{

clear

echo "  _____________________________________"
echo
echo "      Sistema de Backup"
echo "           Versão 0.1"
echo "  Desenvolvido por João, Renan e Thiago"
echo "  _____________________________________"
echo
echo
echo "< -l > Backup local"
echo "< -r > Backup remoto"
echo "<  0 > Sair "
echo
echo "Escolha uma das opções acima:  "
read  opcao

case $opcao in
    l) local ;;
    r) remoto ;;
    0) exit ;;
esac

}

local ()
{

clear && echo -e "${AMARELO}Backup local \n" && tput sgr0
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  rsync -avh --progress "$dir_origem" "$dir_destino" --log-file="$ARQUIVO_LOG" # Alterar as opções se necessário
  Verifica_status
echo
echo "--------------------------------"
echo

    echo "O que deseja fazer agora?"
    echo "< c > Continuar"
    echo "< m >  Menu Principal"
    echo "< s >  Sair"

    echo "Escolha uma opção"
    read op

    if [ "$op" = "c" ]
    then
        soma
    elif [ "$op" = "m" ]
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
  clear && echo -e "${AMARELO}Backup remoto \n" && tput sgr0
  echo "$MENSAGEM_LOG" >> "$ARQUIVO_LOG"
  sudo rsync -avhP --progress -e ssh "$dir_origem" "$dir_destino" --log-file="$ARQUIVO_LOG" # Alterar as opções se necessário
  Verifica_status

echo
echo "--------------------------------"
echo

    echo "O que deseja fazer agora?"
    echo "< c > Continuar"
    echo "< m >  Menu Principal"
    echo "< s >  Sair"

    echo "Escolha uma opção"
    read op

    if [ "$op" = "c" ]
    then
        subtracao
    elif [ "$op" = "m" ]
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

multiplicacao ()
{

    clear
    echo "Digite um número: "
    read num1
    echo "Digite um número: "
    read num2

    mult=$(($num1 * $num2 ))

    echo "Resultado da soma: $mult"

echo
echo "--------------------------------"
echo

    echo "O que deseja fazer agora?"
    echo "< c > Continuar"
    echo "< m >  Menu Principal"
    echo "< s >  Sair"

    echo "Escolha uma opção"
    read op

    if [ "$op" = "c" ]
    then
        multiplicacao
    elif [ "$op" = "m" ]
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

divisao ()
{

    clear
    echo "Digite um número: "
    read num1
    echo "Digite um número: "
    read num2

    div=$(($num1 / $num2 ))

    echo "Resultado da soma: $div"

echo
echo "--------------------------------"
echo

    echo "O que deseja fazer agora?"
    echo "< c > Continuar"
    echo "< m >  Menu Principal"
    echo "< s >  Sair"

    echo "Escolha uma opção"
    read op

    if [ "$op" = "c" ]
    then
        divisao
    elif [ "$op" = "m" ]
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


raizquad ()
{

clear
echo "Digite um número: "
read num

#Iniciando o contandor com 1 pois não existe divisão por zero
i=1


while [ $i -lt $num ]
do

#Variável calc significa cálculo e calc2, cálculo2
#A variável calc fará a divisão do número passado pelo
#usuário e o contador. Em seguida este valor será multiplicado
#por ele mesmo na variável calc2.


    calc=$(($num / $i))
    calc2=$(($calc * $calc ))


#Aqui é realizado o teste que caso seja verdadeiro a
#condição $calc2 for igual a $num, haverá uma interrupção
#no loop (com o comando bread) e será mostrado o comando
#echo logo abaixo


        if [ $calc2 -eq $num ]
        then
            break
        fi
    i=$(($i + 1))
done

echo "A raiz quadrada de $num é: $calc"

echo
echo "--------------------------------"
echo

    echo "O que deseja fazer agora?"
    echo "< c > Continuar"
    echo "< m >  Menu Principal"
    echo "< s >  Sair"

    echo "Escolha uma opção"
    read op

    if [ "$op" = "c" ]
    then
        divisao
    elif [ "$op" = "m" ]
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


################### CHAMAR O MENU PRINCIPAL ###################


menu
