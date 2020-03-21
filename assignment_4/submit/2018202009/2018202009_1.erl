-module('2018202009_1'). 
-import(string,[concat/2]).
-export([main/1]). 

main(CommandLineARG) -> 
    [InFileName, OutFileName] = CommandLineARG,
    Inp_array = readlines(InFileName),
    [M, Token] = Inp_array,
    {ok, Ofile}=file:open(OutFileName, [write]),
    Int_var = 1, 
    Root = self(),
    Pid = spawn(fun() -> start_process(M,Int_var, Root) end),
    Pid ! {Token, Int_var-1, ""},
    receive
        {Msg, Rec_Int_var, File_content} ->
            File_content3 = concat(File_content, "Process " ++ integer_to_list(Int_var-1) ++ " received token " ++ integer_to_list(Msg) ++ " from process " ++ integer_to_list(Rec_Int_var) ++ ".")
            % io:format(File_content3)
    end,
    io:format(Ofile,"~s",[File_content3]).



readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    string:split(Data, [<<"\n">>]),
    L = binary_to_list(Data),
    lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, 
    string:tokens(L, [$\s])).
    
start_process(Count, Int_var, Root) -> 
    % This is the first spawned process 
    Pid = spawn(fun() -> start_process(Count, Int_var+1, self(), Root) end),
    loop(Pid, Int_var, Count).

start_process(Count, Int_var, Last, Root) -> 

    if
        Count - 1 > Int_var -> 
        Pid = spawn(fun() -> start_process(Count, Int_var+1, Last, Root) end), 
        loop(Pid, Int_var, Count); 
    true -> 
        receive
            {Msg, Rec_Int_var, File_content2} ->
            File_content = concat(File_content2, "Process " ++ integer_to_list(Int_var) ++ " received token " ++ integer_to_list(Msg) ++ " from process " ++ integer_to_list(Rec_Int_var) ++ ".\n"),
            Root ! {Msg, Int_var, File_content}
        end
    end.

loop(NextPid, Int_var, _) -> 
    receive 
        {Msg, Rec_Int_var, File_content2} -> 
            File_content = concat(File_content2, "Process " ++ integer_to_list(Int_var) ++ " received token " ++ integer_to_list(Msg) ++ " from process " ++ integer_to_list(Rec_Int_var) ++ ".\n"),
            NextPid ! {Msg, Int_var, File_content}
    end. 
