% erlc <roll_number>_1.erl
% erl -noshell -s <roll_number>_1 main <input_file> <output_file> -s init stop
-module(parallelMergeSort).
-export([main/1]).

main(Args) ->
    [Intput_file_name, Output_file_name] = Args,
    L = readlines(Intput_file_name),
    R = parallelMergeSort(L),
    writeToFile(Output_file_name, R).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]),
    L = binary_to_list(Data),
    lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, 
    string:tokens(L, [$\s])).
    

writeToFile(FileName, L) -> 
    {ok, F}=file:open(FileName, [write]), 
    RE = fileWriter(L, ""),
    io:format(F,"~s", [RE]).

fileWriter([H], _) -> 
    integer_to_list(H);
fileWriter([H|T], R) ->
    R ++ integer_to_list(H) ++ " " ++ fileWriter(T, R).


% Parallel MS
parallelMergeSort(List) -> pms(List, erlang:system_info(schedulers)).
 
pms([L],_) -> [L];
pms(L, N) when N > 1  -> 
    {L1,L2} = lists:split(length(L) div 2, L),
    {Parent, Ref} = {self(), make_ref()},
    spawn(fun() -> L1R = pms(L1, N-2), Parent ! {Ref, L1R} end), 
    spawn(fun() -> L2R = pms(L2, N-2), Parent ! {Ref, L2R} end),
    get_result(Ref);
pms(L, _) -> mergeSort(L).

get_result(Ref) -> 
    receive
        {Ref, L1} -> get_result2(Ref, L1)
    end.

get_result2(Ref, L1) ->
    receive
        {Ref, L2} -> lists:merge(L1, L2)
    end.

% Sequential MS
mergeSort(L) when length(L) == 1 -> L;
mergeSort(L) when length(L) > 1 ->
    {L1, L2} = lists:split(length(L) div 2, L),
    lists:merge(mergeSort(L1), mergeSort(L2)).