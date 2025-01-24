import { Story } from 'inkjs';

export class InkService {
    constructor() {
        this.story = null;
    }

    async loadStory(storyContent) {
        this.story = new Story(storyContent);
    }

    continueStory() {
        const textContent = [];
        const tags = [];

        // Gather all content until we hit a choice
        while (this.story.canContinue) {
            const text = this.story.Continue();
            textContent.push(text);

            // Collect any tags
            if (this.story.currentTags.length > 0) {
                tags.push(...this.story.currentTags);
            }
        }

        return {
            text: textContent,
            tags,
            choices: this.story.currentChoices
        };
    }

    makeChoice(choiceIndex) {
        this.story.ChooseChoiceIndex(choiceIndex);
        return this.continueStory();
    }

    // Save/load functionality
    getSaveState() {
        return {
            storyState: this.story.state.ToJson(),
            currentText: this.currentText,
            currentChoices: this.currentChoices
        };
    }

    loadSaveState(savedState) {
        this.story.state.LoadJson(savedState.storyState);
    }
}