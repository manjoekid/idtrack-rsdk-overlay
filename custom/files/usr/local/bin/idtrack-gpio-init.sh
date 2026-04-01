#!/bin/bash

# IDTrack GPIO init

# Outputs (default LOW)
gpioset --mode=exit gpiochip4 20=0
gpioset --mode=exit gpiochip3 18=0
gpioset --mode=exit gpiochip3 11=0
gpioset --mode=exit gpiochip3 4=0
gpioset --mode=exit gpiochip3 10=0
gpioset --mode=exit gpiochip3 9=0
gpioset --mode=exit gpiochip4 11=0
gpioset --mode=exit gpiochip4 10=0
gpioset --mode=exit gpiochip3 19=0
