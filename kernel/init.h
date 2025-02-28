#ifndef KERNEL_INIT_H
#define KERNEL_INIT_H

#include "fs/tty.h"

// Incredibly sloppy. Please do not reference as an example of good API design.
int mount_root(const struct fs_ops *fs, const char *source);
void set_console_device(int major, int minor);
int become_first_process(void);
int become_new_init_child(void);
int create_stdio(const char *file, int major, int minor);
int create_one_stdio(const char *file, int no, int major, int minor);
int create_piped_stdio(void);
int create_one_piped_stdio(int no);
int create_one_adhoc_fd_stdio(const struct fd_ops *ops, int no);

#endif
