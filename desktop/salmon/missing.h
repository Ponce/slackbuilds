/* headers that should have been included by various salmon
   source files. */
#include <time.h>
#include <ctype.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

/* prototypes for salmon's internal functions. these really
   should have been included in the source... */
void get_phase(time_t the_time, char char_buf[20]);
void open_meminfo(void);
