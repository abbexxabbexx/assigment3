#include "pico/stdlib.h"
#include "hardware/gpio.h"

#define LED0 0
#define LED1 1
#define BTN0 2
#define BTN1 3

static volatile uint32_t last_irq_ms = 0;


static void button_isr(uint gpio, uint32_t events) {
    uint32_t now = to_ms_since_boot(get_absolute_time());
    if (now - last_irq_ms < 50) return;
    last_irq_ms = now;

    
    int b0 = gpio_get(BTN0);
    int b1 = gpio_get(BTN1);

    if (!b0 && !b1) return;

    if (!b1 && b0) {
        gpio_put(LED0, 1);
        gpio_put(LED1, 1);
        return;
    }

    if (!b0 && b1) {
        gpio_put(LED0, 0);
        gpio_put(LED1, 0);
        return;
    }

}

int main() {
    stdio_init_all(); 

    gpio_init(LED0);
    gpio_set_dir(LED0, true);
    gpio_put(LED0, 0);

    gpio_init(LED1);
    gpio_set_dir(LED1, true);
    gpio_put(LED1, 0);

    gpio_init(BTN0);
    gpio_set_dir(BTN0, false);
    gpio_pull_up(BTN0);

    gpio_init(BTN1);
    gpio_set_dir(BTN1, false);
    gpio_pull_up(BTN1);

    gpio_set_irq_enabled_with_callback(BTN0,
        GPIO_IRQ_EDGE_FALL | GPIO_IRQ_EDGE_RISE, true, &button_isr);
    gpio_set_irq_enabled(BTN1, GPIO_IRQ_EDGE_FALL | GPIO_IRQ_EDGE_RISE, true);

    while (true) {
        tight_loop_contents();
    }
}
