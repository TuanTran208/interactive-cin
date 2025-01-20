=== web_shadows_start ===
Your small dorm room is sparse but functional, a stark contrast to the Hidden Academy's grandeur.

* [Approach the evidence board]
    You step closer to examine your work—a rudimentary collection of evidence assembled during your brief stay.
    -> examine_board
* [Get ready for the day]
    The orientation ceremony awaits. But first, you cast a glance at your investigation board.
    -> examine_board

=== examine_board ===
The board contains fragments of your investigation: a map of the Academy, intercepted logs, and the Academy's covert operations insignia, all connected with string.

Among the papers, your clan's badge gleams faintly—worn and faded but unmistakable.

* [Hold the clan badge]
    You pick up the badge, running your thumb over its engraved edges. Your expression hardens, but sorrow lingers in your eyes.
    -> internal_monologue
* [Study the connections]
    Your eyes trace the strings connecting various pieces of evidence. Somewhere in this web lies the truth about what happened to your family.
    -> internal_monologue

=== internal_monologue ===
"The Hidden Academy," you think to yourself. "To the world, it's a place of learning, power, and promise. But beneath its facade lies the truth—the truth about what they did to my family, to my clan."

* ["I will uncover the truth."]
    You place the badge at the center of the board, a silent promise to those you lost.
    -> prepare_for_orientation
* ["They will pay for what they did."]
    You pin the badge back among the clues, your resolve hardening.
    -> prepare_for_orientation

=== prepare_for_orientation === 
The calendar on your desk shows today's event in bold letters: First-Year Orientation Ceremony.

* [Put on your uniform]
    You adjust your uniform carefully, ensuring every detail is perfect. The mask of a regular student must be flawless.
    -> orientation_start
* [Take one last look at the board]
    Before stepping out, you commit the details to memory. Every piece of evidence, every connection could be crucial.
    -> orientation_start
