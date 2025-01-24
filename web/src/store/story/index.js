import { createStore } from 'vuex';
import { InkService } from '@/services/inkService';

const inkService = new InkService();

export default createStore({
    state: {
        currentText: [],
        currentChoices: [],
        tags: [],
        isLoading: false
    },
    mutations: {
        SET_STORY_CONTENT(state, { text, choices, tags }) {
            state.currentText = text;
            state.currentChoices = choices;
            state.tags = tags;
        },
        SET_LOADING(state, loading) {
            state.isLoading = loading;
        }
    },
    actions: {
        async loadStory({ commit }, storyContent) {
            commit('SET_LOADING', true);
            await inkService.loadStory(storyContent);
            const storyState = inkService.continueStory();
            commit('SET_STORY_CONTENT', storyState);
            commit('SET_LOADING', false);
        },
        makeChoice({ commit }, choiceIndex) {
            const storyState = inkService.makeChoice(choiceIndex);
            commit('SET_STORY_CONTENT', storyState);
        }
    }
});