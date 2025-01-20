=== private_exchange_start ===
You find Helios alone in a dimly lit corridor outside the training halls. He leans casually against a column, his sharp eyes studying you with interest.

* [Ask about security]
    "I was wondering about the Academy's security systems," you begin carefully. "They must be quite sophisticated."
    -> security_discussion
* [Inquire about Elara]
    "I'm curious about President Elara," you say. "She seems... remarkable."
    -> elara_discussion

=== security_discussion ===
Helios chuckles, though his eyes remain alert. "You've got an eye for the big picture. But why the sudden interest?"

* [Play it casual]
    "Just trying to understand the rules better. Avoid any... unintended missteps."
    ~ understands_security = true
    -> security_warning
* [Show academic interest]
    "The systems here seem far more advanced than other institutions. It's fascinating."
    ~ understands_security = true
    -> security_warning

=== security_warning ===
"The systems are centralized but adaptive," Helios explains. "They're unmatched—especially around sensitive areas. And they're particularly focused on Elara's office after hours."

* [Note the information]
    You carefully memorize these details while maintaining a look of casual interest.
    -> conversation_end
* [Ask about exceptions]
    "Are there ever exceptions to these security measures?"
    -> conversation_end

=== elara_discussion ===
"Interested in meeting the president?" Helios raises an eyebrow. "That's ambitious for a first-year."

* [Express admiration]
    "Her leadership is inspiring. I'd love to learn from her directly."
    -> elara_access
* [Stay professional]
    "I have some academic proposals I'd like to discuss with her."
    -> elara_access

=== elara_access ===
"First-years rarely meet her unless they're exceptional—or problematic," Helios explains. "The exceptional ones earn her attention. The problematic ones... well, they face consequences."

* [Ask about after hours]
    "What about scheduling a meeting outside normal hours?"
    -> final_warning
* [Thank him politely]
    "I understand. Thank you for explaining."
    -> final_warning

=== final_warning ===
"After hours?" Helios laughs. "Her office is locked down tight then. Only authorized personnel can access it. The surveillance systems are focused there. Trust me, you wouldn't want to trigger those defenses."

* [Accept the warning]
    "Good to know. Wouldn't want to cause any trouble."
    -> conversation_end
* [Play it off]
    "Of course. I was just curious about the protocols."
    -> conversation_end

=== conversation_end ===
As Helios walks away, your mind processes the information gained. Back in your dorm room, you add new notes to your investigation board.

* [Focus on security details]
    You sketch out what you've learned about the security systems. Every detail could be crucial.
    {understands_security: The centralized nature of the system might be its weakness.}
    -> scene_end
* [Consider Elara's schedule]
    You note down the patterns of access to Elara's office. There has to be a way in.
    {identified_elara: Somewhere in that office lie answers about her betrayal.}
    -> scene_end

=== scene_end ===
"No web is impenetrable," you whisper to yourself. "Not even yours, Elara."
-> END