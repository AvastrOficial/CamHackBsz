# CamHackBsz
¿Qué es CamPhish?
<br></br>
> CamPhish es una técnica para tomar fotografías de la cámara del teléfono del objetivo o de la cámara web de la PC. CamPhish aloja un sitio web falso en un servidor PHP integrado y utiliza ngrok y servero para generar un enlace que reenviaremos al objetivo, que se puede utilizar a través de Internet. El sitio web solicita permiso de la cámara y, si el objetivo lo permite, esta herramienta graba imágenes del dispositivo del objetivo.

# Características
> En esta herramienta agregué dos plantillas de página web automáticas para el objetivo comprometido en la página web para obtener más imágenes de la cámara.
- Festival Deseando : simplemente una pagina web del festival 
- YouTube TV en vivo : simplemente ingresa el nombre del festival o el ID del video de youtube

# Instalación y requisitos
> Esta herramienta requiere PHP para servidor web, SSH o enlace de servidor. Primero ejecute el siguiente comando en su terminal
<br></br>
> apt-get -y instalar php openssh git wget
<br></br>
# Instalación (Kali Linux/Termux):
> clon de git https://github.com/baradatipu/CamPhish
<br></br>
> cd camphish
<br></br>
> apt-get -y install php openssh git wget
<br></br>
> pip install -r requirements.txt
<br></br>
> bash camphish.sh



  
