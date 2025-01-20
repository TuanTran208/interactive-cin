
=== nightmare_start ===
# IMAGE: flames.jpg
The grand Blackwood estate burns, flames devouring everything in their path. Shadows dance through the firelight as screams echo through the halls. The scene unfolds in surreal flashes—blurred faces of family members, ominous insignias, and a masked figure orchestrating the slaughter.

* [Hide under the table]
    Your small hands tremble as you clutch a broken family heirloom. 
    The masked figure turns toward you, their weapon catching the firelight. An insignia gleams...
    -> wake_up
* [Try to run]
    Your legs won't move. Fear paralyzes you as the masked figure turns. Their weapon catches the firelight, an insignia gleaming ominously...
    -> wake_up

=== wake_up ===
# CLEAR
You wake abruptly, drenched in sweat. Your heart pounds against your chest as reality slowly comes into focus.

* [Take deep breaths]
    Slowly, your breathing steadies. The familiar confines of your dorm room emerge from the darkness.
    -> scan_room
* [Jump out of bed]
    You spring up, adrenaline coursing through your veins. The familiar sight of your dorm room helps ground you.
    -> scan_room

=== scan_room ===
The small but orderly space is marked by its stark, utilitarian design. A far cry from the grandeur of your childhood home.

* [Look at the window]
    The morning sun filters through, casting long shadows on the walls. Another day at the Hidden Academy awaits.
    -> web_shadows_start
* [Check the time]
    Dawn is breaking. Soon you'll need to prepare for another day at the Hidden Academy.
    -> web_shadows_start
