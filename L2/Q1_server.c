/** @file Q1_server.c
 *  @brief Socket program in C for server.
 *
 *  @author Ritik
 *
 * @date 7/31/2019
 */

#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>
#define PORT 8000

char *server_message =
"HTTP/1.1 200 OK \n\
\n\
<html>\n\
<head>\n\
	<title>Title: CSN 361 - L2</title>\n\
<head>\n\
<body>\n\
	<center>\n\
		<h1>\n\
			Hello from server!\n\
		</h1>\n\
        <h3>\n\
            Submission for Lab assignment 2\n\
        </h3>\n\
	</center>\n\
</body>\n\
</html>";

/** @brief Q1 entrypoint for server.
 */
int main(int argc, char const *argv[]) {
    int server_fd, new_socket, valread;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);
    char buffer[1024] = {0};

    // Creating socket file descriptor
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // Forcefully attaching socket to the port
    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt))) {
        perror("setsockopt");
        exit(EXIT_FAILURE);
    }
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);

    // Bind the socket to localhost
    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address))<0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
    if (listen(server_fd, 5) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    while(1){
	    if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen))<0) {
	        perror("accept");
	        exit(EXIT_FAILURE);
	    }
	    valread = read( new_socket , buffer, 1024);
	    printf("%s\n",buffer );
	    send(new_socket , server_message , strlen(server_message) , 0 );
	    close(new_socket);
	}
    return 0;
}