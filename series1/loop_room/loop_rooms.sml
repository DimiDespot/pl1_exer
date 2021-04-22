fun parse file =
let
  val stream = TextIO.openIn file
  val words = String.tokens Char.isSpace o TextIO.inputAll
  val n::m::rest = words stream
  val (N, M) = (valOf (Int.fromString n), valOf (Int.fromString m))
  fun extractChars (0, acc, _) = rev acc
    | extractChars (i, acc, h::t) =
    let
      val chars = explode (h)
    in
      extractChars ((i-1), (rev chars @ acc), t)
    end
    | extractChars (_, _, _) = nil
in
  (N, M, extractChars (N, [], rest))
end

fun nextRoom (N, M, maze) =
let
  val size = N * M
  fun loop size acc [] = rev acc
    | loop i acc (h::t) =
      case h of
        #"U" => if i < M then loop (i+1) ((~1)::acc) t else loop (i+1) ((i-M)::acc) t
      | #"D" => if i >= ((N-1)*M) then loop (i+1) ((~1)::acc) t else loop (i+1) ((i+M)::acc) t
      | #"L" => if i mod M = 0 then loop (i+1) ((~1)::acc) t else loop (i+1) ((i-1)::acc) t
      | #"R" => if i mod M = M-1 then loop (i+1) ((~1)::acc) t else loop (i+1) ((i+1)::acc) t
      | _ => nil
in
  loop 0 [] maze
end

fun solve N M maze =
let
  val arr = Array.fromList maze
  val visited = Array.array ((N*M), false)
  val canExit = Array.array ((N*M), false)
  fun dfs i =
    if Array.sub(visited, i) = true then Array.sub(canExit, i)
    else (
      Array.update(visited, i, true);
      if Array.sub(arr, i) = ~1 then Array.update(canExit, i, true)
        else Array.update(canExit, i, dfs (Array.sub(arr, i)));
      Array.sub(canExit, i)
    )
  fun countFalse ~1 cnt = cnt
    | countFalse i cnt = if Array.sub(canExit, i) = false then countFalse (i-1) (cnt+1) else countFalse (i-1) cnt
  fun loop ~1 = nil
    | loop i = (
      Array.update(canExit, i, dfs i);
      loop (i-1)
      )
in
  loop (N*M - 1);
  countFalse (N*M - 1) 0
end

fun loop_rooms filename =
let
  val (N, M, maze) = parse filename
  val solution = solve N M (nextRoom (N, M, maze))
in
  print((Int.toString (solution)) ^ "\n")
end
