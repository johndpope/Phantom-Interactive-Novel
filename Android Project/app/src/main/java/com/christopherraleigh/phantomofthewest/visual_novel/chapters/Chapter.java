package com.christopherraleigh.phantomofthewest.visual_novel.chapters;

import com.christopherraleigh.phantomofthewest.visual_novel.IStoryChoiceList;

import java.util.Map;

/**
 * Created by christopherraleigh on 2016-04-19.
 */
public abstract class Chapter implements IChapter {
    //Map<Integer, StoryChoiceList> idToChoices;

    public Chapter() { }

    /*public void addAudio(StoryChoiceList nextList) {
        if (nextList.Count == 1) {

            bool voiceEnabled = DataManager.Voiceover;
            VoiceInformation v = Voiceover;
            if ((voiceEnabled) && (v != null)) {
                string text = nextList[0].Text;
                IVoiceover audio = VoiceoverManager.MainManager.MakeSynthesizedVoiceover(v, text);
                nextList.AudioComponent = audio;
            }
        }
    }*/

    /*public VoiceInformation getVoiceover() {
        throw new UnsupportedOperationException();
    }*/
}
