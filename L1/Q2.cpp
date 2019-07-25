/** @file Q2.cpp 
 *  @brief Q2 Get the MAC address of the interface using
 *         <command> <devicename>
 *
 *  @author Ritik
 */

#include <iostream>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <net/if.h>
#include <unistd.h>

using namespace std;

/** @brief Q2 entrypoint.
 *
 *  @param argc Count of the arguments
 *  @param argv Array of parameters
 */
main(int argc,char **argv){

    if(argc != 2){
	    fprintf(stderr,"usage: <command> <devicename>\n");
	    exit(1);
    }

	unsigned char uc_Mac[32]={0};

	int fd;
	struct ifreq ifr;
	char *iface = argv[1];
	char *mac;
	
	fd = socket(AF_INET, SOCK_DGRAM, 0);

	ifr.ifr_addr.sa_family = AF_INET;
	strncpy((char *)ifr.ifr_name , (const char *)iface , IFNAMSIZ-1);

	ioctl(fd, SIOCGIFHWADDR, &ifr);

	close(fd);

	printf("MAC Address for the device %s : %02x:%02x:%02x:%02x:%02x:%02x\n", argv[1],
	  (unsigned char) ifr.ifr_hwaddr.sa_data[0],
	  (unsigned char) ifr.ifr_hwaddr.sa_data[1],
	  (unsigned char) ifr.ifr_hwaddr.sa_data[2],
	  (unsigned char) ifr.ifr_hwaddr.sa_data[3],
	  (unsigned char) ifr.ifr_hwaddr.sa_data[4],
	  (unsigned char) ifr.ifr_hwaddr.sa_data[5]);
	
	return 0;
}
