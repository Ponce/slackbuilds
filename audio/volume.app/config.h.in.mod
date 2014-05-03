/* config.h */

#define _GNU_SOURCE
#define VERSION "@VERSION@"

#ifndef DEBUG
#define NDEBUG
#endif

/* All these settings should eventually be configurable via libPropList */

/* Note that within the program, the first source is 0 and not 1
 */
#define DEFAULT_SOURCE 0

#define DEFAULT_MIXER_DEVICE "/dev/mixer2"

/* units: seconds
 */
#define MAX_DOUBLE_CLICK_TIME 0.5

/* X11 wheel button codes (for wheel mice)
 */
#define BUTTON_WHEEL_UP 4
#define BUTTON_WHEEL_DOWN 5

/* end config.h */
