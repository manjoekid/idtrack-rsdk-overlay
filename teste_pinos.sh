#!/bin/bash

# Ajuste os gpiochips conforme a placa - Rock5B ou Rock5B+

# Rock5B+

GPIOCHIP1="gpiochip1"
GPIOCHIP3="gpiochip3"
GPIOCHIP4="gpiochip4"

PINS=(
"1_A3:$GPIOCHIP1:3"

"3_A4:$GPIOCHIP3:4"
"3_A7:$GPIOCHIP3:7"
"3_B1:$GPIOCHIP3:9"
"3_B2:$GPIOCHIP3:10"
"3_B3:$GPIOCHIP3:11"
"3_C2:$GPIOCHIP3:18"

"4_B2:$GPIOCHIP4:10"
"4_B3:$GPIOCHIP4:11"
"4_C3:$GPIOCHIP4:19"
"4_C4:$GPIOCHIP4:20"
"4_C5:$GPIOCHIP4:21"
"4_C6:$GPIOCHIP4:22"
)

echo "===== Teste de GPIOs ====="

for pin in "${PINS[@]}"; do
    IFS=":" read NAME CHIP OFFSET <<< "$pin"

    echo
    echo "----------------------------------------"
    echo "Testando $NAME ($CHIP offset $OFFSET)"

    echo "-> Saída LOW"
    gpioset "$CHIP" "$OFFSET=0"
    sleep 0.5
    echo -n "Leitura: "
    gpioget "$CHIP" "$OFFSET"

    echo "-> Saída HIGH"
    gpioset "$CHIP" "$OFFSET=1"
    sleep 0.5
    echo -n "Leitura: "
    gpioget "$CHIP" "$OFFSET"

    echo "-> Retornando para LOW"
    gpioset "$CHIP" "$OFFSET=0"
    sleep 0.2
done

echo
echo "===== Teste concluído ====="
