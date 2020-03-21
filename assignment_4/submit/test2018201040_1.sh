cd 2018201040
erlc 2018201040_1.erl
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in1.txt out1.txt -s init stop
diff ./../../test_cases/tr_output/ans1.txt out1.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in2.txt out2.txt -s init stop
diff ./../../test_cases/tr_output/ans2.txt out2.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in3.txt out3.txt -s init stop
diff ./../../test_cases/tr_output/ans3.txt out3.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in4.txt out4.txt -s init stop
diff ./../../test_cases/tr_output/ans4.txt out4.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in5.txt out5.txt -s init stop
diff ./../../test_cases/tr_output/ans5.txt out5.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in6.txt out6.txt -s init stop
diff ./../../test_cases/tr_output/ans6.txt out6.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in7.txt out7.txt -s init stop
diff ./../../test_cases/tr_output/ans7.txt out7.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in8.txt out8.txt -s init stop
diff ./../../test_cases/tr_output/ans8.txt out8.txt
erl -noshell -s 2018201040_1 main ./../../test_cases/tr_input/in9.txt out9.txt -s init stop
diff ./../../test_cases/tr_output/ans9.txt out9.txt
# rm out* 2018201040_1.beam