=== first_thread_start ===
Helios leads the tour through grand halls lined with display cases and murals depicting the Academy's achievements. His voice carries easily over the quiet footsteps of the group.

* [Stay at the back]
    You maintain a position at the rear of the group, allowing you to observe without drawing attention.
    -> artifact_discovery
* [Listen to Helios]
    You pay attention to Helios's narration, noting any useful information about the Academy's layout and history.
    -> artifact_discovery

=== artifact_discovery ===
The group stops before an ornate display board. Among the ceremonial weapons and relics, something catches your eye—a badge nearly identical to the Blackwood Clan emblem.

* [Study the badge secretly]
    Your heart races as you examine the familiar design, careful not to show your recognition.
    ~ found_clan_badge = true
    -> helios_explanation
* [Note its location]
    You mentally mark the badge's location, planning to return later for a closer look.
    ~ found_clan_badge = true
    -> helios_explanation

=== helios_explanation ===
Helios gestures toward the display, his voice filled with pride. "This hall is dedicated to the Academy's founders and greatest achievements. These relics represent the strength and vision that shaped us."

He pauses before a mural of Elara. "President Elara's leadership transformed the Academy. Her contributions are unmatched, her resolve unwavering."

* [Consider implications]
    {identified_elara: The mural feels like a mockery—Elara Blackwood, celebrated while your clan lies in ashes.}
    {not identified_elara: Something about Elara's portrayal strikes a familiar chord.}
    -> plan_investigation
* [Watch Helios's demeanor]
    His admiration for Elara seems genuine, but could he know the truth about her past?
    ~ suspicious_of_helios = true
    -> plan_investigation

=== plan_investigation ===
As the tour continues, your mind works on a plan to investigate further.

* [Decide to research later]
    You'll need to find a way back to examine that badge more closely.
    -> private_exchange_start
* [Note security details]
    You carefully observe the hall's security measures while appearing to admire the displays.
    -> private_exchange_start
