/** @file Q2_orphan.c
 *  @brief C program to demonstrate Orphan process.
 *  use 'ps aux' command to verify whether parent process exist in process table.
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
    if(k == 0){
        // Child process
        printf("Child created with PID : %d.\n", getpid());
        sleep(100);//child went to sleep
        // Orphan child process
        printf("Child's done\n");
        exit(0);
    }
    else
    {
        // Parent process
        printf("Parent's done\n");
        exit(0); 
        //Parent process terminated
    }
    return 0;
}