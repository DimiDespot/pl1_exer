fun parse file =
let
  val fstream = TextIO.openIn file
  fun int_from_stream stream =
    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) stream)
  fun loop 0 l = rev l
    | loop i l = loop (i-1) ((int_from_stream fstream) :: l)
  val M = int_from_stream fstream
  val N = int_from_stream fstream
  val days = loop M []
in
  (M, N, days)
end


fun findInd (sorted_preSum, n, value) =
let
  val l = ref 0
  val h = ref (n-1)
  val mid = ref 0
  val ans = ref ~1
in
  while !l <= !h do
  let
    val mid = ref ((!l+(!h)) div 2)
    val (s, index) = Array.sub(sorted_preSum, !mid)
  in (
    if s <= value then (ans := !mid; l := !mid + 1)
    else h := !mid - 1
    )
  end;
  !ans
end



fun largestSub arr M k =
let
  val maxlen = ref 0
  val preSum = Array.array(M, (0,0))
  val sum = ref 0
  val minInd = Array.array(M, 0)
  fun arrayToList a = Array.foldr (op ::) [] a
  fun update_preSum 0 = nil
    | update_preSum i = (
      sum := !sum + Array.sub(arr, M-i);
      Array.update(preSum, M-i, (!sum, M-i));
      update_preSum (i-1)
      )
  val junk = update_preSum M
  val list_to_sort = arrayToList preSum
  val sorted_list = ListMergeSort.sort (fn ((a, b), (c, d)) => if a = c then b > d else a > c) list_to_sort
  val sorted_preSum = Array.fromList sorted_list
  val (s, index) = Array.sub(sorted_preSum, 0)
  val temp = Array.update(minInd, 0, index)
  fun min (a, b) = if a > b then b else a
  fun max (a, b) = if a < b then b else a
  fun update_minInd 0 = minInd
    | update_minInd i =
    let
      val (s, index) = Array.sub(sorted_preSum, M-i)
    in
      (
      Array.update(minInd, M-i, min(Array.sub(minInd, M-i-1), index));
      update_minInd (i-1)
      )
    end
  val minInd = update_minInd (M-1)
  val sum = ref 0
  val ind = ref 0
  fun loop 0 = nil
    | loop i = (
      sum := !sum + Array.sub(arr, M-i);
      if !sum > k then maxlen := M-i+1
      else (
        ind := findInd (sorted_preSum, M, !sum-k-1);
        if !ind <> ~1 andalso Array.sub(minInd, !ind) < M-i then maxlen := max (!maxlen, M-i-Array.sub(minInd,!ind))
        else temp
        );
      loop (i-1)
      )


  val temp = loop M
in
  print((Int.toString (!maxlen)) ^ "\n")
end


fun longest file =
let
  val (M, N, days) = parse file
  val correct = map (fn a => (~1)*(a + N)) days
  val arr = Array.fromList correct
in
  largestSub arr M 0
end
