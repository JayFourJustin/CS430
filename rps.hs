-- Justin Choi
-- Rock Paper Scissors Program
data RPS = Rock | Paper | Scissors
data Result = Win | Lose | Draw

instance Show RPS where
    show Rock = "Rock"
    show Paper = "Paper"
    show Scissors = "Scissors"

  
instance Show Result where
    show Win = "Win"
    show Lose = "Lose"
    show Draw = "Draw"

getResults :: RPS -> RPS -> Result
getResults p1 p2 = getResults' (p1, p2)
  where
    getResults' (Rock, Rock) = Draw
    getResults' (Rock, Paper) = Lose
    getResults' (Rock, Scissors) = Win
    getResults' (Paper, Rock) = Win
    getResults' (Paper, Paper) = Draw
    getResults' (Paper, Scissors) = Lose
    getResults' (Scissors, Rock) = Lose
    getResults' (Scissors, Paper) = Win
    getResults' (Scissors, Scissors) = Draw

getMove :: String -> RPS
getMove input = do
  case input of
    "r" -> Rock
    "p" -> Paper
    "s" -> Scissors

append :: Result -> [Result] -> [Result]
append a xs = xs ++ [a]


play :: [Result] -> RPS -> IO ()
play r p2 = do
  input <- getLine

  if input == "q"
    then putStrLn $ show r
  else
    do
      let p1 = getMove input
      let l = length r

      putStrLn $ ("You played " ++ show p1 ++ " and I played " ++ show p2)
      putStrLn $ ("You " ++ show (getResults p1 p2))
      let b = append (getResults p1 p2)  r
      putStrLn $ "Next Round!"

      if l `mod` 10 == 0 || l `mod` 5 == 0
        then play b (getMove "r")
      else if l `mod` 2 == 0
        then play b (getMove "s")
      else play b (getMove "p")

main = do
    putStrLn "Let's Play Rock, Paper, Scissors!"
    putStrLn "Enter your choice: r (Rock), p (Paper), or s (Scissors) (Press q to quit)"
    play [] Rock
    putStrLn "Here's Your Record, Thank you for Playing!"
