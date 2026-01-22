## Sistemas de la Información 2
# Entrega final
Autores:
    - Irene Pascual Albericio - 871627
    - Lucía Vázquez Martín - 871886
    - Ariana Porroche Llorén - 874055


### Instrucciones:
1. En una terminal dentro de la carpeta `codigo` ejecutamos:
    $ docker compose up -d

2. Abrimos el navegador y buscamos la url:
    `http://localhost:8069`

3. Si necesitamos restaurar una copia de la base de datos:
    3.1. Ponemos la `Master-password` que se encuentra en el fichero `./config/odoo.conf`
    3.2. Seleccionamos el archivo `backupFinal.zip`
    3.3. Ponemos un nombre a la base de datos, por ejemplo, `sandbox`
    3.4. Iniciamos el proceso de restauración
    3.5. Una vez cargada la base de datos, la seleccionamos

4. Introducimos las credenciales del usuario administrador:
    `Correo electrónico:` admin
    `Contraseña:` admin

5. Ya accedemos al menú principal de Odoo