# src/components/ui/Button.vue

<template>
    <button
        class="custom-button"
        :class="[variant, size]"
        @click="$emit('click')"
        :disabled="disabled">
        <slot></slot>
    </button>
</template>

<script>
export default {
    name: 'CustomButton',
    props: {
        variant: {
            type: String,
            default: 'primary',
            validator: (value) => ['primary', 'secondary', 'text'].includes(value)
        },
        size: {
            type: String,
            default: 'medium',
            validator: (value) => ['small', 'medium', 'large'].includes(value)
        },
        disabled: {
            type: Boolean,
            default: false
        }
    },
    emits: ['click']
}
</script>

<style scoped>
.custom-button {
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-family: inherit;
    transition: all 0.2s ease;
    width: 100%;
    text-align: left;
    padding: 12px 16px;
    margin: 8px 0;
    background: #f0f0f0;
}

.custom-button:hover:not(:disabled) {
    background: #e0e0e0;
    transform: translateY(-1px);
}

.custom-button:active:not(:disabled) {
    transform: translateY(0);
}

.custom-button:disabled {
    opacity: 0.7;
    cursor: not-allowed;
}

/* Variants */
.primary {
    background: #3498db;
    color: white;
}

.primary:hover:not(:disabled) {
    background: #2980b9;
}

.secondary {
    background: #f0f0f0;
    color: #333;
}

.text {
    background: transparent;
    color: #333;
}

.text:hover:not(:disabled) {
    background: rgba(0, 0, 0, 0.05);
}

/* Sizes */
.small {
    font-size: 0.875rem;
    padding: 8px 12px;
}

.medium {
    font-size: 1rem;
    padding: 12px 16px;
}

.large {
    font-size: 1.125rem;
    padding: 16px 20px;
}
</style>