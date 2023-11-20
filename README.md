# AutoInstall-SSH-Key
## Instalador de Llave Pública SSH


Este es un instalador de llaves SSH que he desarrollado para la empresa GopherGroup, con el propósito de brindar soporte a servidores de una manera más segura.

Lo que hace es instalar la llave pública en un servidor Linux y la coloca en el archivo de autorización de SSH.

Debe modificar las líneas 36 y 38 para indicar la URL donde se encuentra su archivo de llave pública y su archivo de checksum.

Para crear un par de llaves, utilice el siguiente comando en una máquina Linux:

`
ssh-keygen -t rsa -b 4096 -C "gopher"
`

Cambie la palabra "gopher" por lo que desee. (Al cambiar la palabra, también debe modificarla en las líneas 33 y 82 del archivo .sh).

Para conocer el checksum de su llave pública, utilice el siguiente comando en una máquina Linux:

`
md5sum id_rsa.pub
`

## Como instalar y usar 

Para descargar, utilice:
`
curl -o install_accesskey.sh https://clientes.gophergroup.com.co/repo/ssh_install_key.sh
`

Para ejecutar el código, utilice:
`
sh install_accesskey.sh add
`

Para remover la llave, utilice:
`
sh install_accesskey.sh remove
`

## Ajustes a futuro 
Estoy considerando ajustarlo para que el código pueda modificar los valores del archivo sshd_config y permitir el acceso al servidor solo mediante el uso de un par de llaves.

## Codigo fuente
También puede obtener una copia de este código en el repositorio de SolusVM: https://github.com/solusvm-support/helpers/blob/master/install_accesskey.sh
