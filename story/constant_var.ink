
VAR CHARACTER_A = "Kaelin"
VAR CHARACTER_B = "Helios"
VAR CHARACTER_C = "Test" 


// Story variables
VAR DAGGER = false
VAR BERRIES = false
VAR MAP_LAYOUT = false
VAR ROLLING_SKILL = false


// Checkpoint system
VAR current_checkpoint = ""
LIST Checkpoints = attack_checkpoint, to_basement, to_stable, main_gate

// Global variables to track player choices and knowledge
VAR identified_elara = false
VAR suspicious_of_helios = false
VAR found_clan_badge = false
VAR understands_security = false

=== function save_checkpoint(checkpoint_name) ===
~ current_checkpoint = checkpoint_name

=== checkpoint_return ===
{ current_checkpoint:
    - "attack_checkpoint":
        ->-> THE_ATTACK
    - "to_basement":
        ->-> TO_BASEMENT
    - "to_stable":
        ->-> TO_STABLE
    - "main_gate":
        ->-> MAINGATE
    - else:
        ->-> MORNING
}
