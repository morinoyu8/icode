//
//  FileManager.m
//  iCode
//
//  Created by morinoyu8 on 05/09/23.
//

#import "FileManager.h"
#include <string.h>

#if !ISH_LINUX
static ssize_t read_file(const char *path, char *buf, size_t size) {
    struct fd *fd = generic_open(path, O_RDONLY_, 0);
    if (IS_ERR(fd))
        return PTR_ERR(fd);
    ssize_t n = fd->ops->read(fd, buf, size);
    fd_close(fd);
    if (n == size)
        return _ENAMETOOLONG;
    return n;
}

static ssize_t write_file(const char *path, const char *buf, size_t size) {
    struct fd *fd = generic_open(path, O_WRONLY_|O_CREAT_|O_TRUNC_, 0644);
    if (IS_ERR(fd))
        return PTR_ERR(fd);
    ssize_t n = fd->ops->write(fd, buf, size);
    fd_close(fd);
    return n;
}

int create_directory(const char *path) {
    return generic_mkdirat(AT_PWD, path, 0644);
}

static int remove_directory(const char *path) {
    return generic_rmdirat(AT_PWD, path);
}

#else
#define read_file linux_read_file
#define write_file linux_write_file
#define remove_directory linux_remove_directory
#endif

ssize_t create_file(const char *path) {
    return write_file(path, "", 0);
}

char *get_all_path(char *path) {
    struct fd *fd = generic_open(path, O_RDONLY_, 0);
    char all_path[MAX_PATH];
    sprintf(all_path, "%s%s", fd->mount->source, path);
    return all_path;
}


char *get_file_list (const char *path) {
    DIR *dir = opendir(get_all_path(path));
    if (dir == NULL)
        return NULL;
    struct dirent *dp;
    for (dp = readdir(dir); dp != NULL; dp = readdir(dir)) {
        char *tmp = dp->d_name;
        if (tmp == NULL)
            continue;
        if (tmp[0] == '.')
            continue;
        printf("%s\n", tmp);
    }
    closedir(dir);
    
    return "";
}
