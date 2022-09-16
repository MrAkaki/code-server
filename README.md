# CodeServer
Docker image with [code-server](https://github.com/coder/code-server) installed and runing on port 8443

## Configuration

### Storage
´/config´ is the folder where all the non-volatile files are stored

### Passwords
´PASSWORD´ is the login password
´SUDO_PASSWORD´ is the login password in the terminal


## Example
Basic example, completely volatile
´´´
docker run -p8443:8443 -e SUDO_PASSWORD=12345 -e PASSWORD=54321 --name code-server -d mrakaki/code-server
´´´


Basic example, using docker volumes
´´´
docker run -p8443:8443 -e SUDO_PASSWORD=12345 -e PASSWORD=54321 -v storage_folder:/config --name code-server -d mrakaki/code-server
´´´
