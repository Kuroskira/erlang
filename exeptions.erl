-module(exeptions).

-compile(export_all).

%% If no error type is given, throw is assumed.
throws(F) ->
    try F() of
      _ -> ok
    catch
      Throw -> {throw, caught, Throw}
    end.

errors(F) ->
    try F() of
      _ -> ok
    catch
      error:Error -> {error, caught, Error}
    end.

exits(F) ->
    try F() of
      _ -> ok
    catch
      exit:Exit -> {exit, caught, Exit}
    end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) when is_function(Attack, 0) ->
    try Attack() of
      _ -> "None shall pass."
    catch
      slice -> "It is but a scratch.";
      error:cut_arm -> "I've had worse.";
      exit:cut_leg -> "Come on you pansy!";
      _:_ -> "Just a flesh wound."
    end.

talk() -> "Blah Blah".

whoa() ->
    try 
      talk(),
	    _Knight = "None shall Pass!",
	    _Doubles = [N * 2 || N <- lists:seq(1, 100)],
	    throw(up),
	    _WillReturnThis = tequila
    catch
        Exception:Reason -> {caught, Exception, Reason}
    end.
