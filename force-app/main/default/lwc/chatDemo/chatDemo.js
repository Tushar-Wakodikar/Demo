import { LightningElement } from 'lwc';

export default class ChatDemo extends LightningElement {
    inputValue = ''; // Tracks the current input value
    messages = [];   // Stores all the chat messages

    // Handle input change
    handleInputChange(event) {
        this.inputValue = event.target.value;
    }

    // Send message
    sendMessage() {
        if (this.inputValue.trim()) {
            // Create a new message object
            const newMessage = {
                id: this.messages.length + 1,
                text: this.inputValue,
                sender: 'Prashant', // You can replace with dynamic sender names
            };

            // Add the message to the array
            this.messages = [...this.messages, newMessage];

            // Clear the input field
            this.inputValue = '';
        }
    }
}