# src/components/ui/FadeText.vue

<template>
    <p
        class="fade-text"
        :class="{'fade-in': true}"
        :style="{
            animationDelay: `${delay}ms`
        }"
    >
        <slot>{{ text }}</slot>
    </p>
</template>

<script>
export default {
    name: 'FadeText',
    props: {
        text: {
            type: String,
            default: ''
        },
        delay: {
            type: Number,
            default: 0
        }
    }
}
</script>

<style scoped>
.fade-text {
    opacity: 0;
    transform: translateY(20px);
    margin-bottom: 1em;
    line-height: 1.6;
}

.fade-in {
    animation: fadeIn 0.5s ease-out forwards;
}

@keyframes fadeIn {
    0% {
        opacity: 0;
        transform: translateY(20px);
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>