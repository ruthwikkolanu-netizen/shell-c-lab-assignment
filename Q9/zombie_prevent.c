#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int n = 5;                 // number of child processes
    pid_t pid;

    // Create multiple children
    for (int i = 0; i < n; i++) {
        pid = fork();

        if (pid < 0) {
            perror("fork failed");
            exit(1);
        }

        if (pid == 0) {
            // Child process
            printf("Child %d created. PID=%d, ParentPID=%d\n", i + 1, getpid(), getppid());
            sleep(1 + i); // exit at different times
            printf("Child %d exiting. PID=%d\n", i + 1, getpid());
            exit(0);
        }
        // Parent continues loop to create more children
    }

    // Parent process: reap children so they don't become zombies
    int status;
    pid_t childpid;

    while ((childpid = wait(&status)) > 0) {
        printf("Parent cleaned up child PID=%d\n", childpid);
    }

    printf("All children cleaned up. Parent exiting. PID=%d\n", getpid());
    return 0;
}

