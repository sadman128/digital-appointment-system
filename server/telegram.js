// telegram.js

const axios = require("axios");

const TELEGRAM_BOT_TOKEN = '7917966818:AAFolB7yBFrVfGRs1HvVNN2upZ1ERqYfz44';

async function sendMessageToDoctor(chatId, message) {
    try {
        const telegramApiUrl = `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`;

        const response = await axios.post(telegramApiUrl, {
            chat_id: chatId,
            text: message
        });

        if (response.data.ok) {
            console.log(`✅ Message sent to chat ID: ${chatId}`);
        } else {
            console.error(`❌ Failed to send message to chat ID: ${chatId}`, response.data);
        }
    } catch (err) {
        console.error('❌ Error sending Telegram message:', err);
    }
}

// Export the function correctly
module.exports = {
    sendMessageToDoctor
};


//https://api.telegram.org/bot7917966818:AAFolB7yBFrVfGRs1HvVNN2upZ1ERqYfz44/setWebhook?url=https://67ad-45-248-151-130.ngrok-free.app/telegram/webhook