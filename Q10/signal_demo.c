#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

volatile sig_atomic_t got_sigterm = 0;
volatile sig_atomic_t got_sigint = 0;

void handle_sigterm(int sig) {
    got_sigterm = 1;
}

void handle_sigint(int sig) {
    got_sigint = 1;
}

int main() {
    // Install signal handlers
    if (signal(SIGTERM, handle_sigterm) == SIG_ERR) {
        perror("signal SIGTERM");
        return 1;
    }
    if (signal(SIGINT, handle_sigint) == SIG_ERR) {
        perror("signal SIGINT");
        return 1;
    }

    pid_t child1 = fork();
    if (child1 < 0) {
        perror("fork child1");
        return 1;
    }
    if (child1 == 0) {
        // Child 1: send SIGTERM after 5 seconds
        sleep(5);
        kill(getppid(), SIGTERM);
        exit(0);
    }

    pid_t child2 = fork();
    if (child2 < 0) {
        perror("fork child2");
        return 1;
    }
    if (child2 == 0) {
        // Child 2: send SIGINT after 10 seconds
        sleep(10);
        kill(getppid(), SIGINT);
        exit(0);
    }

    // Parent: runs indefinitely until SIGINT arrives
    printf("Parent running indefinitely. PID=%d\n", getpid());
    printf("Child1 will send SIGTERM in 5 seconds.\n");
    printf("Child2 will send SIGINT in 10 seconds.\n");

    while (1) {
        if (got_sigterm) {
            printf("Parent received SIGTERM: handled it (continuing to run).\n");
            got_sigterm = 0;
        }

        if (got_sigint) {
            printf("Parent received SIGINT: exiting gracefully now.\n");
            break;
        }

        sleep(1);
    }

    // Cleanup children
    while (wait(NULL) > 0) {}
    printf("Parent cleanup complete. Exiting.\n");
    return 0;
}
