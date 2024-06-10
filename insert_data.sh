#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

echo $($PSQL "TRUNCATE teams,games");

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv |   while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
  do 
   if [[ $YEAR != 'year' ]]
    then
    #check winner exit 
    WINNER_CHECK=$($PSQL " select * from teams where name='$WINNER'");
    if [[ -z $WINNER_CHECK ]]
      then
      #add winner
      ADD_WINNER=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')");

      if [[ $ADD_WINNER == 'INSERT 0 1' ]]
        then
           echo Insert team $WINNER;
      fi
      #get winner id 
     
    fi
     WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'");
    #check opponent exit
    OPPONENT_CHECK=$($PSQL " select * from teams where name='$OPPONENT'");
    if [[ -z $OPPONENT_CHECK ]]
    then
      #add opponent
      ADD_OPPONENT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT')");

       if [[ $ADD_OPPONENT == 'INSERT 0 1' ]]
       then
           echo Insert team $OPPONENT;
       fi
      
      #get opponent id
     
    fi
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'");
    #add games
    ADD_GAME=$($PSQL "INSERT INTO games ( year,round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)");
    if [[ $ADD_GAME == 'INSERT 0 1' ]]
      then 
        echo game 
      fi







    fi

  done