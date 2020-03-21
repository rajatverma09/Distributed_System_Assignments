cd 2018201040
erlc 2018201040_2.erl
erl -noshell -s 2018201040_2 main ./../../test_cases/ms_input/in1.txt out1.txt -s init stop
diff ./../../test_cases/ms_output/ans1.txt out1.txt
erl -noshell -s 2018201040_2 main ./../../test_cases/ms_input/in2.txt out2.txt -s init stop
diff ./../../test_cases/ms_output/ans2.txt out2.txt
erl -noshell -s 2018201040_2 main ./../../test_cases/ms_input/in3.txt out3.txt -s init stop
diff ./../../test_cases/ms_output/ans3.txt out3.txt
erl -noshell -s 2018201040_2 main ./../../test_cases/ms_input/in4.txt out4.txt -s init stop
diff ./../../test_cases/ms_output/ans4.txt out4.txt
erl -noshell -s 2018201040_2 main ./../../test_cases/ms_input/in5.txt out5.txt -s init stop
diff ./../../test_cases/ms_output/ans5.txt out5.txt
rm out* 2018201040_2.beam