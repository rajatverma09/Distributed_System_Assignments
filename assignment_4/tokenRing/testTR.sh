erlc tokenRing.erl
erl -noshell -s tokenRing main ./../test_cases/tr_input/in1.txt out1.txt -s init stop
diff ./../test_cases/tr_output/ans1.txt out1.txt
erl -noshell -s tokenRing main ./../test_cases/tr_input/in2.txt out2.txt -s init stop
diff ./../test_cases/tr_output/ans2.txt out2.txt
erl -noshell -s tokenRing main ./../test_cases/tr_input/in3.txt out3.txt -s init stop
diff ./../test_cases/tr_output/ans3.txt out3.txt
erl -noshell -s tokenRing main ./../test_cases/tr_input/in4.txt out4.txt -s init stop
diff ./../test_cases/tr_output/ans4.txt out4.txt