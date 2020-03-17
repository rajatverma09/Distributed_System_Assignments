erlc parallelMergeSort.erl
erl -noshell -s parallelMergeSort main ./../test_cases/ms_input/in1.txt out1.txt -s init stop
diff ./../test_cases/ms_output/ans1.txt out1.txt
erl -noshell -s parallelMergeSort main ./../test_cases/ms_input/in2.txt out2.txt -s init stop
diff ./../test_cases/ms_output/ans2.txt out2.txt
erl -noshell -s parallelMergeSort main ./../test_cases/ms_input/in3.txt out3.txt -s init stop
diff ./../test_cases/ms_output/ans3.txt out3.txt
erl -noshell -s parallelMergeSort main ./../test_cases/ms_input/in4.txt out4.txt -s init stop
diff ./../test_cases/ms_output/ans4.txt out4.txt