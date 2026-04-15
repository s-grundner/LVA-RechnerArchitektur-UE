# int a = -7;
addi t0, zero, -7

# int b = 11;
addi t1, zero, 11

# (a >> b)
sra t2, t0, t1

# (a << 3)
slli t3, t0, 3

# -(a << 3)
sub t4, zero, t3

# (a >> b) - (-(a << 3))
sub t5, t2, t4

# (a >> b) - (-(a << 3)) ^ 512
xori a0, t5, 512

# Bei einem shift nach rechts muss bei signed-Datentypen, also auch Integern darauf geachtet werden, das Vorzeichen-Bit nicht zu zerstören. 
# Daher wird dieser in einen arithmetischen-Shift übersetzt, welcher das Vorzeichen-Bit mit einem Bit mit der selben Wertigkeit wie die seines Vorgängers ersetzt.
# Bei einem shift nach links jedoch gibt es dieses Problem nicht und es wird ein logischer Shift verwendet.