/** @file Q1.c
 *  @brief Q1 get childs and grandchilds of a process.
 *
 *  @author Ritik
 */

#include <stdio.h>
#include <unistd.h>
#include<sys/wait.h> 

/** @brief Q1 entrypoint.
 */
int main()

{
  int pid = -1, pid1 = -1, pid2 = -1, pid11 = -1, pid12 = -1, pid21 = -1, pid22 = -1;
  int ppppid = getpid();

  pid1 = fork(); // child1
  pid2 = fork(); //child2

  if(pid1>0 && pid2>0){ //parent
    printf("First child PID: %d..(%d).\n", pid1, ppppid);
    printf("Second child PID: %d.\n", pid2);
  }
  else if(pid1==0 && pid2>0)
  { // child1
    pid11 = pid2;
    pid12 = fork();
   
    if(pid12 != 0){ // child1
      printf("First Grandchild PID: %d.\n", pid11);
      printf("Second Grandchild PID: %d.\n", pid12);
    }
  }

  else if(pid2==0 && pid1!=0){
    int i = 1000000;
    while (i > 0){
      i--;
    }
    pid21 = fork();
    if(pid21 != 0){ //child2
   
      pid22 = fork();
      if(pid22 != 0){ //child2
     
        printf("Third Grandchild PID: %d.\n", pid21);
        printf("Fourth Grandchild PID: %d.\n", pid22);
       
        printf("Parent PID: %d.\n", ppppid);
      }
    }
  }
}