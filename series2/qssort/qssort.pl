%// Οι παρακάτω 4 γραμμές κώδικα αντιγράφηκαν από το σάιτ:
%// https://stackoverflow.com/questions/20104042/prolog-and-or-expressions-boolean-function
and(A,B):- is_true(A), is_true(B).
is_true(true).      %// no need to include any cases with false, it'll fail anyway
is_true(A):- var(A), !, false.  %// prevent it from generating too much stuff
is_true(and(A,B)):- and(A,B).

solve_aux(N, Q, S, I, Qs, Ss, Seen, Sorted, TempAns, Answer) :-
  ( and(Qs = Ss, Qs = I) -> ( Q = Sorted -> writeln("hi"), halt. )


  )

loop_entry(N, Q, S, I, Seen, Sorted, TempAns, Answer) :-
  solve_aux(N, Q, S, I, 0, 0, Seen, Sorted, TempAns, Answer),
  dif(Q, Sorted),
  J is I+1,
  loop_entry(N, Q, S, I, Seen, Sorted, TempAns, Answer).

solve(N, Q, Sorted, Answer) :-
  ( Q = Sorted -> Answer = "empty"
  ; I = 1,
    Seen = [],
    S = [],
    loop_entry(N, Q, S, I, Seen, Sorted, TempAns, Answer),
  ).

qssort(File, Answer) :-
  read_input(File, N, Q),
  sort(Q, Sorted),
  solve(N, Q, Sorted, Answer).

read_input(File, N, Q) :-
  open(File, read, Stream),
  read_line(Stream, N),
  read_line(Stream, Q).

read_line(Stream, L) :-
  read_line_to_codes(Stream, Line),
  atom_codes(Atom, Line),
  atomic_list_concat(Atoms, ' ', Atom),
  maplist(atom_number, Atoms, L).
