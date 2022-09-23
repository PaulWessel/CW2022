gmt begin
#gmt math -T0/100/1 420 330 SUB 90 SQRT 48 SQRT SUB DIV T SQRT MUL 86 ADD = fw_equation.txt
gmt math -T0/100/1 420 330 SUB 90 SQRT 48 SQRT SUB DIV T SQRT MUL 86 ADD DUP 230 GT MUL DUP 0 EQ 230 MUL ADD = fw_equation_230.txt
#gmt figure fw_equation230_xSQRT
#gmt plot fw_equation_230.txt -JX6ip0.5/6i -B -R0/100/0/450
gmt end show