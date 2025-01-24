# src/components/StoryPlayer/StoryPlayerMain.vue

<template>
    <div class="story-player">
        <story-content :content="currentText" />
        <story-choices 
            :choices="currentChoices" 
            @make-choice="makeChoice"
        />
    </div>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import StoryContent from './StoryContent.vue';
import StoryChoices from './StoryChoices.vue';

export default {
    name: 'StoryPlayerMain',
    components: {
        StoryContent,
        StoryChoices
    },
    computed: {
        ...mapState(['currentText', 'currentChoices', 'isLoading'])
    },
    methods: {
        ...mapActions(['loadStory', 'makeChoice'])
    },
    async mounted() {
        // Load story on component mount
        const storyResponse = await fetch('/stories/main-story.json');
        const storyContent = await storyResponse.json();
        await this.loadStory(storyContent);
    }
}
</script>

<style scoped>
.story-player {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}
</style>