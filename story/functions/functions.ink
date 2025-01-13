INCLUDE  constant_var.ink

=== function suit(x) 
    ~ return Suits(INT(FLOOR(LIST_VALUE(x) / 100)))
    
=== function number(x) 
    ~ return Values(LIST_VALUE(x) mod 100)



=== function value(x) 
    ~ return MIN(LIST_VALUE(x) mod 100, 10)

=== function shuffle()
    ~ PackOfCards = LIST_ALL(PackOfCards)

=== function addSpecificCardOfValue(ref toHand, val, faceUp)
    ~ temp x = pullCardOfValue(val)
    ~ return addSpecificCard( toHand, x, faceUp)

=== function addSpecificCard(ref toHand, x, faceUp) 
    ~ toHand += x 
    {faceUp:
        ~ faceUpCards += x
    }
    ~ return x
    
=== function addCard(ref toHand, faceUp)
    ~ temp x = pullCardOfValue(LIST_ALL(Values))
    ~ temp retVal = addSpecificCard( toHand, x, faceUp)
    ~ return retVal 
    
    
=== function pullCardOfValue(valuesAllowed)
    ~ temp card = pop_random(PackOfCards) 
    { card: 
        { valuesAllowed !? number(card):
            ~ return pullCardOfValue(valuesAllowed)
        }
        ~ return card 
    }
    [ Error: couldn't find a card of value {valuesAllowed}! ]
    ~ shuffle()
    ~ return pullCardOfValue(valuesAllowed)
    
=== function nameCard(x) 
    {_nameCard(x, true) }
    
=== function _nameCard(x, allowVariants)
    ~ temp num = number(x)
    {allowVariants:
        { RANDOM(1, 3) == 1:
            a{(Eight, Ace) ? num :<>n} {num} in {suit(x)}
        - else:
            the {num} of {suit(x)}
        }
    - else: 
        {num} of {suit(x)}
    }
    
=== function printHandDescriptively(x, mine) 
    {printHand(faceUpCards ^ x)} face up
    ~ temp faceDownCards = x - faceUpCards
    {faceDownCards:
        <>, and <>
        { mine:
            {printHand(faceDownCards)}
        - else:
            {print_number(LIST_COUNT(faceDownCards))} <> more
        }
        <> {~{mine:hidden|}|face down|blind}
    }
    
=== function printHand(x)
    ~ _printHand(x)
=== function _printHand(x) 
    ~ temp y = pop(x) 
    {y:
        {nameCard(y)}
        {LIST_COUNT(x):
        - 0:    
            ~ return 
        - 1:
            <> and {_printHand(x)}
        - else:
            <>, {_printHand(x)}
        }
    }
    
== function listMyCards() 
    ~ _listOfCards(myCards)
== function _listOfCards(hand) 
    ~ temp y = pop(hand) 
    { y: 
        <>{_nameCard(y, false)}
        {hand:
            <><br>
            ~ _listOfCards(hand)
        }
    }
     

    
=== function isPontoon(x) 
    ~ return handContains(x, Ace) && ( handContains(x, King) || handContains(x, Queen) || handContains(x, Jack) ) && LIST_COUNT(x) == 2
    
=== function handContains(x, card) 
    ~ temp y = pop(x) 
    { y: 
        { number(y) == card: 
            ~ return true 
        - else:
            ~ return handContains(x, card)
        }
    }    
    ~ return false
    
=== function minTotalOfHand(x)
    ~ temp y = pop(x) 
    {y:
        ~ return minTotalOfHand(x) + value(y)
    }
    ~ return 0

=== function maxTotalOfHand(x)
    ~ temp minTot = minTotalOfHand(x)
    {handContains(x, Ace) && minTot <= 11:
        ~ return minTot + 10 
    - else: 
        ~ return minTot
    }
    
=== function sayTotalOfHand(x) 
    ~ temp minTot = minTotalOfHand(x)
    { shuffle:
    -   for a total of 
    -   total of 
    -   giving 
    -   making 
    }
    <> {print_number(minTot)} 
    { handContains(x, Ace)  && minTot <= 11:
        ~ temp max = maxTotalOfHand(x)
        <>, or {print_number(maxTotalOfHand(x))}
    }
=== function finalTotalOfHand(x) 
    { isPontoon(x): 
        pontoon
    - else:
        {print_number(maxTotalOfHand(x))} 
    }


=== function describeMyCards()
    { shuffle:
    -   V:      ... {printHandDescriptively(myCards, true)}. #thought
    - { shuffle:
        -   CARSTAIRS:  {~First {~card|out|up} {!for you} is|} 
            
        -   CARSTAIRS:  The lady {~has|gets} 
            
        }
        <> {nameCard(faceUpCards ^ myCards)}
        V:  ... and face down, {nameCard(myCards - faceUpCards)} ... #thought
    }
    V:      ... {sayTotalOfHand(myCards)} ... #thought




== function describePot(bet)
    { shuffle:
    -   CARSTAIRS:  The {~bet|stake|pot} is {print_number(bet)} pounds.
    -   CARSTAIRS:  {~That makes|{~There|That}'s} {print_number(bet)} pounds {~in the pot|on the table}. 
    }
    
=== function pop_random(ref _list) 
    ~ temp el = LIST_RANDOM(_list) 
    ~ _list -= el
    ~ return el 
=== function print_number(x) 
{
    - x >= 1000000:
        ~ temp k = x mod 1000000
        {print_number((x - k) / 1000000)} million{ k > 0:{k < 100: and|{x mod 100 != 0:<>,}} {print_number(k)}}
    - x >= 1000:
        ~ temp y = x mod 1000
        {print_number((x - y) / 1000)} thousand{ y > 0:{y < 100: and|{x mod 100 != 0:<>,}} {print_number(y)}}
    - x >= 100:
        ~ temp z = x mod 100
        {print_number((x - z) / 100)} hundred {z > 0:and {print_number(z)}}
    - x == 0:
        zero
    - x < 0: 
        minus {print_number(-1 * x)}
    - else:
        { x >= 20:
            { x / 10:
                - 2: twenty
                - 3: thirty
                - 4: forty
                - 5: fifty
                - 6: sixty
                - 7: seventy
                - 8: eighty
                - 9: ninety
            }
            { x mod 10 > 0:
                <>-<>
            }
        }
        { x < 10 || x > 20:
            { x mod 10:
                - 1: one
                - 2: two
                - 3: three
                - 4: four
                - 5: five
                - 6: six
                - 7: seven
                - 8: eight
                - 9: nine
            }
        - else:
            { x:
                - 10: ten
                - 11: eleven
                - 12: twelve
                - 13: thirteen
                - 14: fourteen
                - 15: fifteen
                - 16: sixteen
                - 17: seventeen
                - 18: eighteen
                - 19: nineteen
            }
        }
} 
=== function came_from(-> x) 
    ~ return TURNS_SINCE(x) == 0
=== function pop(ref _list) 
    ~ temp el = LIST_MIN(_list) 
    ~ _list -= el
    ~ return el 
/*
	Tests if the flow passes a particular gather "very recently" - that is, within the last 3 turns.

	Usage: 

	- (welcome)
		"Welcome!"
	- (opts)
		*	{seen_very_recently(->welcome)}
			"Sorry, hello, yes."
		+	"Er, what?"
			-> opts
		*	"Can we get on with it?"
		
*/
=== function seen_more_recently_than(-> link, -> marker)
	{ TURNS_SINCE(link) >= 0: 
        { TURNS_SINCE(marker) == -1: 
            ~ return true 
        } 
        ~ return TURNS_SINCE(link) < TURNS_SINCE(marker) 
    }
    ~ return false 

   



/*
	Takes the bottom element from a list, and returns it, modifying the list.

	Returns the empty list () if the source list is empty.

	Usage: 

	LIST fruitBowl = (apple), (banana), (melon)

	I eat the {pop(fruitBowl)}. Now the bowl contains {fruitBowl}.

*/
=== function seen_very_recently(-> x)
    ~ return TURNS_SINCE(x) >= 0 && TURNS_SINCE(x) <= 3