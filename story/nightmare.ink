
=== nightmare_start ===
-> MORNING

=== MORNING ===
Kealin wakes up and gets dressed.
Leave the room
* [Go to training yard] -> TO_TRAINING_YARD
* [Go to kitchen] -> TO_KITCHEN

=== choose_path ===
+ [Return to last checkpoint] -> load_checkpoint


=== load_checkpoint ===
-> checkpoint_return -> DONE

=== TO_TRAINING_YARD ===
Kealin is heading toward the training yard.
You hear noise from the horse stable on the way.
* [Go to the horse stable] -> HORSE_STABLE
* [Continue to training yard] -> TRAINING_YARD

=== TO_KITCHEN ===
Kealin is heading toward the kitchen.
You hear noise from the horse stable on the way.
* [Go to the horse stable] -> HORSE_STABLE
* [Continue to kitchen] -> KITCHEN

=== TRAINING_YARD ===
Kealin reaches the training yard and watches the soldiers train.
You see the weapon rack.
Tries to steal a dagger.
TODO MINIGAME: STEAL DAGGER
// MINIGAME: STEAL DAGGER would go here
Playing MINIGAME: STEAL DAGGER
* [Success]
    ~ DAGGER = true
    Kealin hides the dagger in pocket.
    ** [Go to the horse stable]
    -> HORSE_STABLE_1
* [Fail]
    ~ DAGGER = false
    The dagger drops to the ground.
    A soldier picks it up.
    ** [Go to the horse stable]
    -> HORSE_STABLE_1

=== KITCHEN ===
Kealin reaches the kitchen and asks the Cook for something to eat.
The Cook says he has to wait for the family to have breakfast together.
Kealin tries to steal some berries.
TODO MINIGAME: STEAL BERRIES
Playing MINIGAME: STEAL BERRIES
* [Success]
    ~ BERRIES = true
    Kealin hides the dagger in pocket.
    ** [Go to the horse stable]
    -> HORSE_STABLE_1
* [Fail]
    ~ BERRIES = false
   The bowl drops to the ground.
    A servant picks it up
    ** [Go to the horse stable]
    -> HORSE_STABLE_1

=== HORSE_STABLE ===
Kealin reaches the stable and sees uncle Elara feeding the horses.
Kealin greets him but startles Elara.
Kealin asks Elara why he trouble himself with the chore of the servants.
Elara says he’s bored so he decides to feed the horses.
Kealin asks to join Elara feed the horses.
Elara agrees.

+ [Breakfast time] -> BREAKFAST

=== HORSE_STABLE_1 ===
Kealin goes to the horse stable.
Don’t see anything.
The horses are enjoying the food.
{ BERRIES:
    * [A horse tries to reach] 
    One of the horses sniff at Kealin’s pocket.
    Kealin feeds the horse a berry.
    The horse likes it.
    ** [Breakfast time] -> BREAKFAST
- else:
    * [Breakfast time] -> BREAKFAST
}

=== BREAKFAST ===
Kealin has breakfast with the family.
Lord Alaric asks Kealin what he wants to learn today.
* [Reading] -> READ_ABOUT_THE_HOUSE
* [Combat training] ->COMBAT_TRAINING

===COMBAT_TRAINING===
Kealin goes to the training yard and train with the captain
    ~ ROLLING_SKILL = true
* [It was a long day] -> END_OF_DAY

=== READ_ABOUT_THE_HOUSE ===
Kealin goes to the family library and reads a record about the estate of house Blackwood.
~ MAP_LAYOUT = true
* [It was a long day] -> END_OF_DAY

=== END_OF_DAY ===
~ save_checkpoint("evening_checkpoint")
After a long day, Kealin has dinner with the family.
Then he goes back to his room and rest.
* [Let’s sleep]-> THE_ATTACK

=== THE_ATTACK ===
~ save_checkpoint("attack_checkpoint")
Loud explosion at the main gate.
Kealin wakes up.
The raiders flood in.
Chaos breaks out as the raiders attack house Blackwood.
* [Find Lord Alaric] -> HEAD_TO_ALARIC
* [Find uncle Elara] -> HEAD_TO_ELARA



=== HEAD_TO_ALARIC ===
Kealin tries to go to Lord Alaric's room.
You hear gunshots from his room.
* [Run away] -> FOUND_SIGIL

=== HEAD_TO_ELARA ===
Kealin goes to uncle Elara's room but can't find him.
You hear gunshots somewhere else in the house.
* [Run away] -> FOUND_SIGIL


=== FOUND_SIGIL ===
Kealin runs aways in panic
He trips while running and sees a sigil droped by one of the raiders, decides to pick it up.
Another loud explosion. The chandalier right above Kealin falls down.
{ ROLLING_SKILL:
    Kealin rolls and avoids the chandalier.
    * [Run to living room] -> HIDING_IN_LIVING_ROOM
- else:
    TODO MINIGAME: EVADE CHANDALIER
    Playing MINIGAME: EVADE CHANDALIER
    * [Success] Kealin rolls and avoids the chandalier.
        ** [Run to living room] -> HIDING_IN_LIVING_ROOM
    * [Fail] Kealin is crushed by the chandalier -> DEATH
}


===HIDING_IN_LIVING_ROOM===
Kealin hides under the big table in the living room.
He tries to calm down while thinking about where to go next
{ MAP_LAYOUT:
    * [Head to basement] -> TO_BASEMENT
}
    * [Head to the stable] -> TO_STABLE

=== DEATH ===
You have died.
+ [Return to last checkpoint] -> load_checkpoint


=== TO_BASEMENT ===
~ save_checkpoint("to_basement")
Kealin heads toward the basement because he remembers from the record he read earlier there’s a secret route that leads to the forest.
While heading there, he sees a raider holding a club.
{ DAGGER:
    * [Attack] -> ATTACK_RAIDER_BASEMENT
}
    * [Sneak] -> SNEAK_RAIDER_BASEMENT

=== ATTACK_RAIDER_BASEMENT ===
Kealin jumps out to ambush the raider with his dagger and kills him
* [Continue to the basement] -> BASEMENT
=== SNEAK_RAIDER_BASEMENT ===
Kealin tries to sneak pass the raider unnoticed.
TODO MINIGAME: SNEAK
Playing MINIGAME: SNEAK
* [Success]
    Kealin sneaks pass the raider unnoticed.
    ** [Continue to the basement] -> BASEMENT
* [Fail]
    The raider found and attack Kealin.
{   DAGGER:
    TODO MINIGAME: DEFEND
    * [Success] Kealin kills the raider
        ** [Continue to the basement] -> BASEMENT
    * [Fail] The raider kills Kealin. -> DEATH
- else:
    The raider kills Kealin. -> DEATH
}

=== TO_STABLE ===
~ save_checkpoint("to_stable")
Kealin heads toward the stable, hoping to find a horse to escape.
Once he gets there, he sees 1 horse is missing and the rest are dead.
He tries to go to the main gate instead.
While heading there he sees a group of raiders with swords and guns.
{ DAGGER:
    * [Attack] -> ATTACK_RAIDERS_STABLE
}
    * [Sneak] -> SNEAK_RAIDER_BASEMENT
===ATTACK_RAIDERS_STABLE===
Kealin tries to attack the group of raiders but they outnumber and kill him.
-> DEATH

===SNEAK_RAIDERS_STABLE===
Kealin tries to sneak pass the group of raiders.
TODO MINIGAME: SNEAK
Playing MINIGAME: SNEAK
* [Success]
    -> MAINGATE
* [Fail]
    The raiders found and kills Kealin.
    -> DEATH

=== MAINGATE ===
~ save_checkpoint("main_gate")
Kealin sneaks pass the raiders unnoticed. He reaches the main gate and sees the horses of the raiders
* [Ride a horse] Kealin aproaches a horse but seems like it doesn’t like Kealin
{ BERRIES:
    ** [Feed berry to the horse] Kealin takes the last berry from his pocket and feeds it to the horse.
    The horse calms down.
    Kealin rides the horse to escape into the forest.
    -> WAKES_UP
- else:
    ** [Try to calm it down] Kealin try to pet the horse to calm it down but he horse neighs loudly.
        The raiders found and kills Kealin.
        -> DEATH
}
* [Sneak] Kealin tries to sneaks pass the horses.
    TODO MINIGAME: SNEAK
    Playing MINIGAME: SNEAK
    ** [Success] Kealin sneaks pass the horses, then runs to the forest and escape.
        -> WAKES_UP
    ** [Fail] Kealin triped and startle the horses, making them neigh loudly.
        The raiders found and kills Kealin.
        -> DEATH

=== BASEMENT ===
Kealin reaches the basement and escape to the forest.
-> WAKES_UP

// Continue rest of the story...
=== WAKES_UP ===
WIP: Continue rest of the story...
->NEXT_SCENE



===NEXT_SCENE===
* [Continue the next scene] -> web_shadows_start