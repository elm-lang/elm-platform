#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> /* for fork */
#include <sys/types.h> /* for pid_t */
#include <sys/wait.h> /* for wait */

int main() {
    /* Spawn a child process to run Haskell. */
    pid_t pid = fork();

    if (pid == 0) { /* child process */
        static char *argv[] =
            { "runhaskell", "BuildFromSource.hs", "0.15.1", NULL };

        execvp("runhaskell", argv);

        exit(127); /* only if execvp fails */
    } else { /* parent process */
        waitpid(pid, 0, 0); /* wait for child to exit */
    }

    return 0;
}
