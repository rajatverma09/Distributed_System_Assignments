cd 2018202009
erlc 2018202009_2.erl
time erl -noshell -s 2018202009_2 main ./../../test_cases/ms_input/in1.txt out1.txt -s init stop
diff ./../../test_cases/ms_output/ans1.txt out1.txt
time erl -noshell -s 2018202009_2 main ./../../test_cases/ms_input/in2.txt out2.txt -s init stop
diff ./../../test_cases/ms_output/ans2.txt out2.txt
time erl -noshell -s 2018202009_2 main ./../../test_cases/ms_input/in3.txt out3.txt -s init stop
diff ./../../test_cases/ms_output/ans3.txt out3.txt
time erl -noshell -s 2018202009_2 main ./../../test_cases/ms_input/in4.txt out4.txt -s init stop
diff ./../../test_cases/ms_output/ans4.txt out4.txt
time erl -noshell -s 2018202009_2 main ./../../test_cases/ms_input/in5.txt out5.txt -s init stop
diff ./../../test_cases/ms_output/ans5.txt out5.txt
rm out* 2018202009_2.beam