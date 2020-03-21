-module('2018202009_2'). 
% -export([merge_sort/1, start/2]). 
-export([main/1, readlines/1, start/2, receive_Sorted_list/3]). 
% -export([merge_sort/2, main/2, readlines/1, start/2, receive_Sorted_list/1, receive_Sorted_list2/2]). 

% -export([merge_sort/1, start/1, rec/1]). 

%erlang:system_info(schedulers)
% merge_sort(File_name, Num_of_proc) -> main(File_name, Num_of_proc).

main(CommandLineARG) ->
    [File_name,OutFile_name] = CommandLineARG,
    statistics(runtime),
    statistics(wall_clock),
    % your code here


    % io:format("inside input "),
    Input_array = readlines(File_name),
    {_, Time1} = statistics(runtime),
    U1 = Time1,
    Sorted_array = start(Input_array, 16),
    {_, Time2} = statistics(wall_clock),
    U2 = Time2,
    % Time = U2-U1,
    % io:format(" Time taken is ~p ",U1),
    io:format("Code time=~p milliseconds~n",
    [U2]),
    % io:format(" done sorting "),
    {ok, Ofile}=file:open(OutFile_name, [write]),
    Str = fileWriter(Sorted_array, ""),
    io:format(Ofile,"~s",[Str]).
    % Data = lists:flatten(io_lib:format("~p",[Sorted_array])),
    % Str1 = string:sub_string(Data, 2, length(Data)-1),
    % Str = re:replace(Str1, ",", " ", [global, {return, list}]),
    % io:format(Ofile,"~s",[Str]).
    % io:write(Ofile,Str).

fileWriter([H], _) -> 
    integer_to_list(H);
fileWriter([H|T], R) ->
    R ++ integer_to_list(H) ++ " " ++ fileWriter(T, R).
    

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    string:split(Data, [<<"\n">>]),
    L = binary_to_list(Data),
    lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, 
    string:tokens(L, [$\s])).

start([Input_array],_) -> [Input_array]; %If it's not an array but a single integer, return the same

start(Input_array, No_of_processors) when No_of_processors > 1->
    {Left_subarray, Right_subarray} = lists:split(length(Input_array) div 2, Input_array),
    Reference_id = make_ref(),
    Process_id = self(),
    spawn(fun()-> Process_id ! {left_msg, Reference_id, start(Left_subarray, No_of_processors-2)} end),
    spawn(fun()-> Process_id ! {right_msg, Reference_id, start(Right_subarray, No_of_processors-2)} end),
    % {Received_left, Received_right} = receive_Sorted_list(Reference_id),
    {Received_left, Received_right} = receive_Sorted_list(Reference_id, undefined, undefined),

    lists:merge(Received_left, Received_right);
start(Input_array, _) -> {Left_subarray, Right_subarray} = lists:split(length(Input_array) div 2, Input_array), lists:merge(start(Left_subarray, 0), start(Right_subarray,0)).

% receive_Sorted_list(Reference_id) ->
%     receive 
%         {left_msg, Reference_id, Received_left} -> receive_Sorted_list2(Reference_id, Received_left)
%         % {right_msg, Reference_id, Received_right} -> receive_Sorted_list2(Reference_id, Received_left)
        
% %     {right_msg, Reference_id, Received_right} when Left_subarray == undefined -> receive_Sorted_list(Reference_id, Left_subarray, Received_right);
%     %     {left_msg, Reference_id, Received_left} -> {Received_left, Right_subarray};
%     %     {right_msg, Reference_id, Received_right} -> {Left_subarray, Received_right}
%     % after 5000 -> receive_Sorted_list(Reference_id, Left_subarray, Right_subarray)
%     end.

% receive_Sorted_list2(Reference_id, Received_left) ->
%     receive
%         {right_msg, Reference_id, Received_right} -> {Received_left, Received_right}
%     end.

receive_Sorted_list(Reference_id, Left_subarray, Right_subarray) ->
    receive 
        {left_msg, Reference_id, Received_left} when Right_subarray == undefined -> receive_Sorted_list(Reference_id, Received_left, Right_subarray);
        {right_msg, Reference_id, Received_right} when Left_subarray == undefined -> receive_Sorted_list(Reference_id, Left_subarray, Received_right);
        {left_msg, Reference_id, Received_left} -> {Received_left, Right_subarray};
        {right_msg, Reference_id, Received_right} -> {Left_subarray, Received_right}
    after 5000 -> receive_Sorted_list(Reference_id, Left_subarray, Right_subarray)
    end.