#include "pico/stdlib.h"
#include "hardware/gpio.h"

void link_gpio_init(uint pin) {
    gpio_init(pin);
}

void link_gpio_set_dir(uint pin, bool is_output) {
    gpio_set_dir(pin, is_output);
}

void link_gpio_pull_up(uint pin) {
    gpio_pull_up(pin);
}
