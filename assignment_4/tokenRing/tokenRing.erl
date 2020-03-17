% erlc <roll_number>_1.erl
% erl -noshell -s <roll_number>_1 main <input_file> <output_file> -s init stop
-module(tokenRing).
-export([main/1]).

main(Args) ->
    [Intput_file_name, Output_file_name] = Args,
    L = readlines(Intput_file_name),
    [N, Value]= L,
    I = 0,
    {ok, F}=file:open(Output_file_name, [write]), 
    {Root, Parent} = {self(), make_ref()},
    Pid = spawn(fun() -> ring(I + 1, N, Value, Root, Parent, F) end),
    Pid ! {Value, I, Parent},
    receive 
        {Value, From, Root} -> io:format(F, "Process ~p received token ~p from process ~p.", [I,Value,From])
    end.

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]),
    L = binary_to_list(Data),
    lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, 
    string:tokens(L, [$\s])).

ring(I, N, Value, Root, Parent, F) -> 
    if 
      I < N -> 
          receive 
            {Value, From, Parent} -> io:format(F, "Process ~p received token ~p from process ~p.~n", [I,Value,From]),
            Child_id = make_ref(),
            Pid = spawn(fun() -> ring(I + 1, N, Value, Root, Child_id, F) end),
            Pid ! {Value, I, Child_id}
            end;
      true -> 
        Root ! {Value, I - 1, Root}
    end.