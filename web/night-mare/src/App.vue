
<template>
  <div class="app">
    <header class="header">
      <h1>{{ title }}</h1>
    </header>

    <main class="main-content">
      <story-player
        v-if="!isLoading"
        @story-complete="handleStoryComplete"
      />
      <div v-else class="loading">
        Loading story...
      </div>
    </main>

    <footer class="footer">
      <button @click="restartStory" class="restart-button">
        Restart Story
      </button>
    </footer>
  </div>
</template>

<script>
import { defineComponent } from 'vue';
import StoryPlayerMain from './components/StoryPlayer/StoryPlayerMain.vue';
import { mapState, mapActions } from 'vuex';

export default defineComponent({
  name: 'App',

  components: {
    StoryPlayer: StoryPlayerMain
  },

  data() {
    return {
      title: 'Interactive Story'
    };
  },

  computed: {
    ...mapState(['isLoading'])
  },

  methods: {
    ...mapActions(['loadStory']),

    async restartStory() {
      try {
        const response = await fetch('/stories/main-story.json');
        const storyContent = await response.json();
        await this.loadStory(storyContent);
      } catch (error) {
        console.error('Failed to restart story:', error);
      }
    },

    handleStoryComplete() {
      console.log('Story completed!');
      // Handle story completion - maybe show a replay button or credits
    }
  },

  async mounted() {
    try {
      const response = await fetch('/stories/main-story.json');
      const storyContent = await response.json();
      await this.loadStory(storyContent);
    } catch (error) {
      console.error('Failed to load story:', error);
    }
  }
});
</script>

<style>
.app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
    'Helvetica Neue', Arial, sans-serif;
}

.header {
  text-align: center;
  padding: 2rem;
  background: #f8f9fa;
}

.header h1 {
  margin: 0;
  font-size: 2rem;
  color: #343a40;
}

.main-content {
  flex: 1;
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  width: 100%;
  box-sizing: border-box;
}

.loading {
  text-align: center;
  padding: 2rem;
  color: #6c757d;
}

.footer {
  text-align: center;
  padding: 1rem;
  background: #f8f9fa;
}

.restart-button {
  padding: 0.5rem 1rem;
  font-size: 1rem;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.restart-button:hover {
  background: #0056b3;
}

/* Mobile responsiveness */
@media (max-width: 768px) {
  .main-content {
    padding: 1rem;
  }

  .header h1 {
    font-size: 1.5rem;
  }
}
</style>