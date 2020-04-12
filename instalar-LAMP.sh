#!/bin/bash
# Jardel F.V. jardel.fv@gmail.com

# Atenção! lembre-se de dar a permição de execução do arquivo: chmod +x arquivo.sh ####
# Script de instalação da pilha LAMP ###

pesquisa=$(dpkg --get-selections | grep "curl")
if [ -n "$pesquisa" ]; then
        echo ""
else
        echo "O pacote curl não foi encontrado iremos instalar para você"
        echo "Instalando..."
        sudo apt install curl
fi

pesquisa=$(dpkg --get-selections | grep "curl")
if [ -n "$pesquisa" ]; then
        echo ""
else
        echo "O pacote dialog não foi encontrado iremos instalar para você"
        echo "Instalando..."
        sudo apt install dialog
fi

while :; do

        resposta=$(
                dialog --stdout                       \
                        --title 'Menu instalção LAMP' \
                        --menu 'Escolha uma opção:'   \
                        0 0 0                         \
                        1 'Instalar o LAMP Server'    \
                        2 'Ver meu IP'                \
                        0 'Sair'
        )

        # Caso apertar CANCELAR ou ESC, então vamos sair...
        [ $? -ne 0 ] && break

        # Executa as ações de acordo com a opção escolhida
        case "$resposta" in
        1)
                dialog                                         \
                --title 'Aguarde'                           \
                --infobox '\nFinalizando em 5 segundos...'  \
        
                echo "Instalando o apache..."
                sudo apt install apache2 libapache2-mod-php -y &&
                echo "Instalando o MariaDB..."
                sudo apt install mariadb-server -y &&
                echo "Instalando o PHP..."
                sudo apt install php php-mysql -y
                0 0

                dialog                                         \
                --title 'Parabéns'                             \
                --msgbox 'Instalação finalizada com sucesso.'  \
                6 40

                meuIP=$(hostname -I | awk '{print $1}')
                echo "Você deverá utilizar este IP $(hostname -I | awk '{print $1}'), no seu navegador da internet para testar o servidor"
                break
                ;;

        2)
                dialog \
                        --cr-wrap \
                        --sleep 5 \
                        --backtitle 'Menu instalção LAMP' \
                        --title 'Seu IP' \
                        --infobox "
                Dados de rede
                IP Local   : $(hostname -I | awk '{print $1}')
                IP Externo : $ipExterno$(curl http://icanhazip.com)

                " 14 40
                break
                ;;

        0) break ;;
        esac

done
clear
# Mensagem final

if [ -n "$meuIP" ]; then
        echo "Você deverá utilizar este IP $meuIP, no seu navegador da internet para testar o servidor"
else
        echo "Saindo do script"

fi
