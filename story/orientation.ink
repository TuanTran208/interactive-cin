=== orientation_start ===
The orientation hall stretches vast and majestic before you, its domed ceiling adorned with intricate murals depicting the Academy's history. Fellow students sit in hushed anticipation, their whispers echoing off marble walls.

* [Listen quietly]
    You take your seat, maintaining a facade of calm as you observe your surroundings.
    -> elara_entrance
* [Study the crowd]
    From your seat, you study the faces around you, wondering if any hold secrets like yours.
    -> elara_entrance

=== elara_entrance ===
The tall double doors swing open. President Elara strides onto the elevated stage, her presence commanding immediate silence.

* [Watch her carefully]
    A memory stirs—her voice, from before the purge. Elara Blackwood. The outcast who now leads the very institution that destroyed your clan.
    ~ identified_elara = true
    -> elara_speech
* [Maintain composure]
    You keep your expression neutral, though your heart races at her appearance.
    -> elara_speech

=== elara_speech ===
"Welcome to the Hidden Academy," Elara's voice resonates with practiced confidence. "A sanctuary of excellence, innovation, and strength. You are here because you are exceptional."

Her tone shifts, becoming more serious: "But with privilege comes responsibility. Greatness demands sacrifice, and the path you walk here will be neither easy nor forgiving."

* [Study her mannerisms]
    {identified_elara: You search for traces of the woman you once knew—Elara Blackwood, before she betrayed your clan.}
    There's something calculated in her every gesture.
    -> helios_introduction
* [Listen for hidden meanings]
    Her words about sacrifice carry a weight she couldn't possibly think you'd understand.
    -> helios_introduction

=== helios_introduction ===
Elara gestures to a tall, sharp-eyed young man at her side. "To guide you on your first steps, I present Helios, my trusted second-in-command."

Helios steps forward with a professional yet warm smile. "Welcome, everyone. You've made it through the hardest part—getting in. Now comes the fun part."

* [Join the tour group]
    You blend seamlessly into the crowd of students following Helios.
    {identified_elara: Your mind races with questions about Elara's true identity.}
    -> first_thread_start
* [Linger to watch Elara]
    You take your time joining the group, watching Elara's departure.
    {identified_elara: The outcast of your clan, now its destroyer. What game is she playing?}
    -> first_thread_start
