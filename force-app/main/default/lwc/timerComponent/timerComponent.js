import { LightningElement, track } from 'lwc';

export default class TimerComponent extends LightningElement {
    running = false;
    elapsedTime = 60;
    
    get startStopLabel() {
        return this.running ? 'Stop' : 'Start';
    }

    connectedCallback() {
        this.updateTime();
    }

    updateTime() {
        if (this.running) {
            this.elapsedTime -= 1;
        }

        const MILLISECONDS = 1000;

        setTimeout(() => {
            this.updateTime();
        }, MILLISECONDS); 

    }

    toggleStartStop() {
        this.running = !this.running;
    }

    reset() {
        this.running = false;
        this.elapsedTime = 60;
    }
}