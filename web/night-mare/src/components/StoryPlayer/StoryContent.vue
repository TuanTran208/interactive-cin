<template>
    <div class="story-content">
        <fade-text
            v-for="(text, index) in content"
            :key="index"
            :text="text"
            :delay="index * 100"
        />
    </div>
</template>

<script>
import FadeText from '../ui/FadeText.vue';

export default {
    components: { FadeText },
    props: {
        content: {
            type: Array,
            required: true
        }
    }
}
</script>