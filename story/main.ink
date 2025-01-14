
/*

    This is a simplified version of the pontoon game from Overboard! 

    A deck of cards is properly simulated and dealt. The player can then bet on additional cards, before the AI characters (Carstairs, an English gentleman and card shark) will play.

    In the real game (www.inklestudios.com/overboard) conversation options are added between hands, and there a few other more nefarious strategies for tilting the game in your favour!

*/
INCLUDE functions/functions.ink

-> play_game -> END 
/*------------------------------------------

    GAMEPLAY CONTENT LOOP

------------------------------------------*/

=== play_game

- (top_of_game)
    
    ~ temp startingMoney = money
    
    ~ myCards = () 
    
    ~ hisCards = () 
    ~ faceUpCards = ()

    ~ temp bet = 20
    
    { once:
    -   VO:     I throw two ten-pound notes onto the table. 
    -   V:  Twenty pounds. 
        CARSTAIRS:     The pot stands at twenty pounds.
    -   VO:     I toss in my ante. 
    }
    
    {
    
    - LIST_COUNT(PackOfCards) < 10:
        ~ shuffle()
        ~ temp plural = RANDOM(1,2)
        
        VO:         Carstairs {~collects together|gathers up} {plural:{~all|} the cards|the deck}, and {~riffles|shuffles} {plural:them|it} {~thoroughly|expertly|quickly|carelessly||} before dealing the first two cards.
        
    - else:
        
        VO:     Carstairs {~passes me|spins me|tosses over|deals out} {~{~an opening|a new} card|my first card} {~face up|} {~from the {~top of the|} deck|}.
    }
    ~ temp myNewCard = ()
    
    ~ myNewCard = addCard(myCards, true) 
    
    
    { shuffle:
    -   CARSTAIRS:  {~First {~card|out} is|} {nameCard(myNewCard)}. 
            
    -   CARSTAIRS:  The lady {~has|gets|receives} {nameCard(myNewCard)}.
    }
    
    ~ temp hisNewCard =  addCard(hisCards, true) 
    { stopping:
    -   CARSTAIRS:  And the dealer... gets {nameCard(hisNewCard)}.
        - 
        { shuffle:
        -   CARSTAIRS: And it's {nameCard(hisNewCard)} for me. 
                
        -   CARSTAIRS:  {~Dealer {~gets...|has}|And I have} {nameCard(hisNewCard)}.
        }
    }
    
    {once:
    -   CARSTAIRS:      You can fold, or make a bet to stay in.
    }

    ~ temp incr = 0
- (bet_opts)
    +   [ Fold ]
        
        V:  {~Pass|Fold}. 
        -> i_lost
        
    +   [ Bet 50  ]
        ~ incr =  50
    +   {money - bet < 200} [ Bet 100   ] 
        ~ incr = 100
    +   {money - bet >= 200} [ Bet higher... ] 
        + + {CHOICE_COUNT() < 2 }  {money - bet <= 300} [   Bet 100   ]
            ~ incr = 100
        + + {CHOICE_COUNT() < 2 } {money - bet <= 250} [   Bet 150    ]
            ~ incr =  150
        + + {CHOICE_COUNT() < 2 } [   Bet 200   ]
            ~ incr =  200
        + + {CHOICE_COUNT() < 2 } {money - bet >= 300} [   Bet 300   ]
            ~ incr = 300
        + + [ Bet lower... ] 
            -> bet_opts
                
                
-   
    { shuffle:
    -   V:  I put in {print_number(incr)} pounds {incr > 50: more}. 
    -   V:  I raise {print_number(incr)} pounds.
    }
    { incr >= 200: 
        
        { shuffle once:
        -   VO:     Carstairs raises an eyebrow. 
        -   CARSTAIRS:  Crikey. 
        -   CARSTAIRS:  Well, now. 
        -   CARSTAIRS:  Someone's feeling lucky. 
        }
    
    }
 -      ~ bet += incr
        
        { describePot(bet) }
        
        { shuffle:
        -   VO:     He {~hands|deals} {~me|out} a second card, face-down. 
        -   CARSTAIRS:  Here's your next card.
            { RANDOM(1, 2):
               VO:     He slides it across the table to me, face down. 
            }
        }
        
        {once:
        -   CARSTAIRS:  Take a look, don't let me see.
        }
        
        ~ myNewCard = addCard(myCards, false)  
        
        
        V:  ... {nameCard(myNewCard)}: {sayTotalOfHand(myCards)} ... #thought
        
        ~ addCard(hisCards , false) 
        
        { shuffle:
        -   VO:     He deals one more for himself, face down. 
        -   CARSTAIRS:  One more blind for me, too. 
        }
  
- (myplay) 

    { minTotalOfHand(myCards) > 21:
        { shuffle:
        -   V:  I'm bust. 
        -   V:  Damn.
        -   VO:     I {~toss|throw} my cards down. 
        }
        { i_lost mod 3 == 2:
            { shuffle: 
            -   V:  You're rigging this. 
            -   V:  How are you doing this? 
            -   V:  This can't be fair. 
            }
            { shuffle:
            -   CARSTAIRS:  I assure you I'm not! 
            -   CARSTAIRS:  I play the odds, Ma'am, not the player. 
            -   CARSTAIRS:  I promise you, I'm as square as they come!
            }
            
        
        }
        -> i_lost
    }
    { LIST_COUNT(myCards) == 5: 
        CARSTAIRS:  A five card trick! 
        CARSTAIRS:  That beats the same value on fewer cards.
    }
 
 - (check_for_burn)  
    { LIST_COUNT(myCards) == 2 && minTotalOfHand(myCards) == 13 && money - bet >= 20: 
        +   {came_from(-> burny)} 
            [ Burn again ] 
            -> burny 
        +   (burny) {not came_from(-> burny)} 
            [ Burn for twenty more ] 
            ~ bet += 20 
            V:  Burn. 
            >>> AUDIO CardCollectAndDealTwoCards
            VO:     Carstairs collects in the cards and deals two more.
            ~ faceUpCards -= myCards
            ~ myCards = () 
            ~ addCard(myCards, true)
            ~ addCard(myCards, false)
            V:      ... {printHandDescriptively(myCards, true)} ... #thought
            V:      ... {sayTotalOfHand(myCards)} ... #thought

            -> check_for_burn
            
        *   [ Keep them ] 
            -> bid_loop
    - else: 
        -> bid_loop   
    }
    -> DONE 
    
- (bid_loop)  

    { not seen_very_recently(->  describePot): 
        { describePot(bet) }
    }
    ~ temp gotTwentyOne = (maxTotalOfHand(myCards) == 21)
    {gotTwentyOne:
        {isPontoon(myCards):
            V:  ... It's a pontoon..!  #thought
        - else: 
            V:  ... Twenty-one!   #thought
        }
        
    }
    
    +   [ Stick {not gotTwentyOne: on {finalTotalOfHand(myCards)}} ]
        CARSTAIRS:  Final bet is {print_number(bet)} pounds. 
        -> hisplay_begins
        
    *   (gloat) {gotTwentyOne} [ Gloat ] 
        >>> AUDIO: V Chuckle 1
        V:  You're in trouble now, Mr Carstairs...
        CARSTAIRS:  Is that so?
        -> hisplay_begins
        
    *   {gotTwentyOne} [ Give nothing away ] 
        >>> AUDIO: V Clear Throat 1
        V:          Your turn, then.
        CARSTAIRS:  I take it you're sticking, then?
        -> hisplay_begins
        
    +   {not gotTwentyOne} [ Twist ] 
        { shuffle:
        -   V:  Twist. 
        -   V:  Another card. 
        -   V:  Give me another.
        -   V:  One more, face up.
        }
        ~ temp newUpCard = addCard(myCards, true)
        
        CARSTAIRS:  {nameCard(newUpCard)}.
        
        V:  ... {sayTotalOfHand(myCards)}. #thought
        -> myplay
        
    +   { (money - bet) >= 50 }  {not gotTwentyOne}
        [ Buy for fifty ]
        ~ bet += 50 
        ~ temp newDownCard = addCard(myCards, false)
        {shuffle:
        -   V:  Buy. 
        -   V:  I'll buy one. 
        -   V:  One more, face down.
        }
        {shuffle:
        -   CARSTAIRS:  The stake is now {print_number(bet)}. 
        -   CARSTAIRS:   {print_number(bet)} in the pot. 
        }
       
        { shuffle:
        -   VO:     Carstairs passes me another card, face-down. 
        -   CARSTAIRS:   Here's your card.
        }
       
        V:  ... {nameCard(newDownCard)}. #thought
        V:  ... {sayTotalOfHand(myCards)}. #thought
        -> myplay
        
- (hisplay_begins)  

    ~ faceUpCards += hisCards 
    { shuffle:
    -   CARSTAIRS:  Let's see what I have...
        CARSTAIRS:  {printHandDescriptively(hisCards, false)}.
    -   CARSTAIRS:  Dealer has... {printHandDescriptively(hisCards, false)}.
    }
    
    CARSTAIRS:  {sayTotalOfHand(hisCards)}.
 
- (hisplay_main)
    // AI plays 
    
    ~ temp hes_scared = seen_more_recently_than(-> gloat, -> top_of_game)
    
    ~ temp hisTotal = minTotalOfHand(hisCards) 
    
    { hisTotal > 21:  
        { shuffle:
        -   CARSTAIRS:  I'm bust!
        -   CARSTAIRS:  Too high! 
        -   CARSTAIRS:  No luck there!
        }
        -> i_won 
    }
    
    ~ temp hisMaxTotal = maxTotalOfHand(hisCards) 
    
    ~ temp yourVisibleTotal = maxTotalOfHand(myCards ^ faceUpCards)
    ~ temp yourBestTotal = 21 
    
    // edge case. You have ? - 3 - 5 => your best is 19.
    { LIST_COUNT(myCards - faceUpCards) == 1 && yourVisibleTotal < 10: 
        ~ yourBestTotal = 11 + yourVisibleTotal
    }
    
    +   {hisMaxTotal > yourBestTotal || (hisMaxTotal == yourBestTotal && LIST_COUNT(myCards) < 5)} ->
        - - (he_sticks)
            CARSTAIRS:  Dealer sticks on {finalTotalOfHand(hisCards)}.
            -> hisplayover
    +   { hisMaxTotal >= 18 && !handContains(hisCards, Ace)}   -> he_sticks
    
    +   { hisTotal == 10 || hisTotal == 11 } -> he_twists
    
    +   { hisMaxTotal <= 15 || (hisMaxTotal <= 17 && handContains(hisCards, Ace)) || (hisMaxTotal <= 18 && hes_scared) } -> 
        - - (he_twists)
            { shuffle:
            -   CARSTAIRS: I'll take another. 
            -    CARSTAIRS: Dealer twists. 
            -    CARSTAIRS: One more...
            }
            
            ~ temp newHisCard = addCard(hisCards, true)
            CARSTAIRS:  {nameCard(newHisCard)}, {sayTotalOfHand(hisCards)}.
            -> hisplay_main
        
    +   {RANDOM(1, 3) == 1} -> 
        -> he_sticks 
        
    +   -> he_twists
    
- (hisplayover) 
    
    ~ temp facedownCards = myCards - faceUpCards
    
- (dealoutcards)
    { pop(facedownCards):
        -> dealoutcards
    }
    
    
    ~ temp scoreDiff = maxTotalOfHand(myCards) - maxTotalOfHand(hisCards)
    { cycle:
    -   VO:     I lay my cards down. 
    -  VO:     I {~turn|flip} my cards {~face-up|over}. 
      -  
    }
    
    { cycle:
    -   V:  I've got {scoreDiff < 0:only} {finalTotalOfHand(myCards)}{scoreDiff==0:<> too}.
    -  V:      {finalTotalOfHand(myCards)}.
    }
    
    { 
    - scoreDiff > 0 && maxTotalOfHand(myCards) < 21: 
        {stopping:
        -   V:  I won? 
        -   {cycle: 
                - V:  I won. 
                - 
            }
        }
        -> i_won 
    - scoreDiff < 0: 
        CARSTAIRS:  Dealer wins! 
        -> i_lost 
    - scoreDiff == 0: 
        { LIST_COUNT(myCards) >= 5 && LIST_COUNT(hisCards) < 5: 
            CARSTAIRS:  Five card trick wins!
            -> i_won 
        }
        CARSTAIRS:  It's a draw. Dealer wins, I'm afraid.
        -> i_lost 
    }
    
    
- (i_won)
    ~ money += bet 
    ~ CstrsBank -= bet
    
    VO:     I collect up the money from the table. 
    { 
    - isPontoon(myCards): 
        CARSTAIRS:  And pontoon earns double. 
        ~ money += bet 
        ~ CstrsBank -= bet
        
        VO:     He counts out another {print_number(bet)} pounds. 
    - maxTotalOfHand(myCards) == 21 && LIST_COUNT(myCards) == 2:
        { once:
        -   CARSTAIRS:  But it's not a pontoon, I'm afraid. 
            CARSTAIRS:  Need a face card for that.
            
        }
    }
    
    { shuffle:
    -   VO:     I've now got {print_number(money)} pounds. 
    -   V:      ... I've now got {print_number(money)} pounds. 
    }  
    
    -> done 

- (i_lost)

    ~ money -= bet
    ~ CstrsBank += bet
    VO:     Carstairs {~takes|{~collects|scoops} {~up|}} the {~pot|stake|money {~{~off|from} the table|}} and gathers up the cards. 
    { money < 50: 
        V:  You've cleaned me out! 
        CARSTAIRS:  I'm sorry to hear that, Mrs V. 
        CARSTAIRS:  Thanks for the game. 
        
        
        VO:     He tucks his winnings into his waistcoat pocket and grins like an idiot.
        -> finished
    }
    { money >= startingMoney:
        { shuffle:
        -   VO:     I've still got {print_number(money)} pounds. 
        }
    - else: 
        { shuffle:
        -   V:      ... I'm down to {print_number(money)} pounds ... #thought
        -   V:     ... {print_number(money)} pounds left ...  #thought
        }
    }
    -> done 
    
- (done)

    ~ temp wasPontoon = isPontoon(myCards)
    ~ myCards = ()
    
    { CstrsBank <= 50:
        CARSTAIRS:  Well, you've cleaned me out of spending money, Mrs Villensey! 
        CARSTAIRS:  I must say; a much better show than your husband achieved. 
        -> finished
    }
    
    {
    - came_from(-> i_lost): 
        {shuffle: 
        -   CARSTAIRS:       Have you had enough? 
        -   CARSTAIRS:       Keep going?  
        -   CARSTAIRS:       Again?
        }
    - came_from(-> i_won): 
        { shuffle:
        -    CARSTAIRS:      Another round? 
        -    CARSTAIRS:      Again? 
        -    CARSTAIRS:      Another? 
        }
    - else:     
        { cycle:
        -   VO:     Carstairs {~has been squaring up|is fiddling with} the {~pack|deck}.
        -   VO:     Carstairs is shuffling idly. 
            ~ shuffle()
        }
        { shuffle: 
         -    CARSTAIRS:      Are we still playing?
         -    CARSTAIRS:      Another hand, Mrs Villensey?
        }
    }
    
 - (replay_opts)  
    
    +   [ Play another round ] 
        { 
        - money >= 250:
            { shuffle:
            -   V:  Hit me. 
                
            -   V:  Deal.
                
            -   V:  Let's try again.
                
            -   V:  Another!
                
            }
        - money >= 100:
            { shuffle:
            -   V:  I'll play another round.
                
            -   V:  I'll play a little more. 
                
            -   V:  I'm not finished yet.
            }
        -  money >= 70:
            { shuffle:
            -   V:  I can afford one more round.
            -   V:  I'd better be lucky this time! 
            }
        }
        -> top_of_game 
    
    
       
    +   [ Stop playing ] 
        {shuffle:
        -   V:  Perhaps later.  
        -   V:  Another time, perhaps. 
        }
            
    - (finished)
        ~ myCards = ()
        
        ->->
