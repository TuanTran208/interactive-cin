<!-- InkStoryPlayer.vue -->
<template>
  <div class="ink-story">
    <!-- Loading state -->
    <div v-if="!story" class="p-4 text-center text-gray-600">
      Loading story...
    </div>

    <div v-else>
      <!-- Story container -->
      <div class="max-w-2xl mx-auto p-4 bg-white dark:bg-gray-800 shadow-lg rounded-lg">
        <!-- Save/Load controls -->
        <div class="mb-4 flex gap-2">
          <button
            @click="saveState"
            class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600"
          >
            Save
          </button>
          <button
            @click="loadState"
            :disabled="!hasSavedState"
            class="px-3 py-1 bg-green-500 text-white rounded hover:bg-green-600 disabled:opacity-50"
          >
            Load
          </button>
          <button
            @click="restart"
            class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600"
          >
            Restart
          </button>
        </div>

        <!-- Story text -->
        <div
          class="prose dark:prose-invert mb-4 whitespace-pre-wrap"
          v-html="formattedText"
        ></div>

        <!-- Error message -->
        <div
          v-if="errorMessage"
          class="text-red-500 mb-4 p-2 bg-red-100 rounded"
        >
          {{ errorMessage }}
        </div>

        <!-- Choices -->
        <div v-if="currentChoices.length > 0" class="space-y-2">
          <button
            v-for="choice in currentChoices"
            :key="choice.index"
            @click="handleChoiceClick(choice)"
            class="w-full p-2 text-left bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 rounded transition-colors"
          >
            {{ choice.text }}
          </button>
        </div>

        <!-- Story end indicator -->
        <div
          v-if="isStoryEnd"
          class="mt-4 text-center text-gray-600 dark:text-gray-400"
        >
          --- The End ---
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { Story } from 'inkjs'

// Props
const props = defineProps({
  storyContent: {
    type: Object,
    required: true
  }
})

// State
const story = ref(null)
const currentText = ref('')
const currentChoices = ref([])
const errorMessage = ref('')
const isStoryEnd = ref(false)

// Computed
const hasSavedState = computed(() => {
  return localStorage.getItem('inkStoryState') !== null
})

const formattedText = computed(() => {
  return currentText.value
    .replace(/\n/g, '<br>')
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.*?)\*/g, '<em>$1</em>')
})

// Methods
const continueStory = () => {
  if (!story.value) return

  try {
    let text = ''
    while (story.value.canContinue) {
      text += story.value.Continue() + '\n'

      // Handle any tags
      const tags = story.value.currentTags
      if (tags.length > 0) {
        handleTags(tags)
      }
    }

    currentText.value = text
    currentChoices.value = story.value.currentChoices
    isStoryEnd.value = !story.value.canContinue && story.value.currentChoices.length === 0
    errorMessage.value = ''
  } catch (error) {
    errorMessage.value = 'An error occurred while continuing the story: ' + error.message
    console.error('Story error:', error)
  }
}

const handleChoiceClick = (choice) => {
  if (!story.value) return

  try {
    story.value.ChooseChoiceIndex(choice.index)
    continueStory()
  } catch (error) {
    errorMessage.value = 'An error occurred while processing your choice: ' + error.message
    console.error('Choice error:', error)
  }
}

const handleTags = (tags) => {
  tags.forEach(tag => {
    if (tag.startsWith('CLASS:')) {
      // Handle class tags
      const className = tag.split(':')[1].trim()
      // Add class handling logic here
    } else if (tag.startsWith('IMAGE:')) {
      // Handle image tags
      const imagePath = tag.split(':')[1].trim()
      // Add image handling logic here
    }
  })
}

const saveState = () => {
  try {
    const savedState = story.value.state.toJson()
    localStorage.setItem('inkStoryState', savedState)
    errorMessage.value = ''
  } catch (error) {
    errorMessage.value = 'Failed to save story state: ' + error.message
    console.error('Save error:', error)
  }
}

const loadState = () => {
  try {
    const savedState = localStorage.getItem('inkStoryState')
    if (savedState) {
      story.value.state.LoadJson(savedState)
      continueStory()
    }
    errorMessage.value = ''
  } catch (error) {
    errorMessage.value = 'Failed to load saved state: ' + error.message
    console.error('Load error:', error)
  }
}

const restart = () => {
  try {
    story.value = new Story(props.storyContent)
    currentText.value = ''
    currentChoices.value = []
    isStoryEnd.value = false
    errorMessage.value = ''
    continueStory()
  } catch (error) {
    errorMessage.value = 'Failed to restart story: ' + error.message
    console.error('Restart error:', error)
  }
}

// Initialize story when content is provided
watch(() => props.storyContent, (newContent) => {
  if (newContent) {
    story.value = new Story(newContent)
    continueStory()
  }
}, { immediate: true })

// Clean up on component unmount
onMounted(() => {
  window.addEventListener('beforeunload', saveState)
  return () => {
    window.removeEventListener('beforeunload', saveState)
  }
})
</script>

<style scoped>
.prose {
  max-width: none;
}
</style>