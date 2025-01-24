<template>
    <div class="choices-container" v-if="choices.length">
        <custom-button
            v-for="(choice, index) in choices"
            :key="index"
            @click="$emit('make-choice', index)"
            :class="{'fade-in': true}"
            :style="{ animationDelay: `${index * 100}ms` }"
        >
            {{ choice.text }}
        </custom-button>
    </div>
</template>

<script>
import CustomButton from '../ui/Button.vue';

export default {
    components: { CustomButton },
    props: {
        choices: {
            type: Array,
            required: true
        }
    },
    emits: ['make-choice']
}
</script>