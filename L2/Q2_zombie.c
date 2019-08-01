/** @file Q2_zombie.c
 *  @brief C program to demonstrate Zombie process.
 *  use 'ps aux' command to verify whether child process exist in process table.
 *
 *  @author Ritik
 *
 * @date 7/31/2019
 */

#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>

/** @brief Q2 entrypoint.
 */
int main(){
    printf("Parent's PID : %d.\n", getpid());
    int k = fork();
    if(k != 0){
        sleep(100);//parent went to sleep
        printf("Parent's done\n");
    }
    else
    {
        printf("Child's PID : %d.\n", getpid());
        printf("Child's done\n");
        exit(0); //child process terminated
    }
    return 0;
}