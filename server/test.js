const myHeaders = new Headers();
myHeaders.append("Authorization", "App 7fb16f8ed92c92472c7b8e4f771fea7f-657de62b-830f-4430-9347-28ab05a8bbea");
myHeaders.append("Content-Type", "application/json");
myHeaders.append("Accept", "application/json");

const raw = JSON.stringify({
    "messages": [
        {
            "from": "447860099299",
            "to": "8801674853822",
            "messageId": "8006157f-f33f-4c06-910f-1c57be9de7dd",
            "content": {
                "templateName": "test_whatsapp_template_en",
                "messages": ["hello", "world"],
                "templateData": {
                    "body": {
                        "placeholders": ["Sadman"]
                    }
                },
                "language": "en"
            }
        }
    ]
});

const requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: raw,
    redirect: "follow"
};

fetch("https://8kq1l9.api.infobip.com/whatsapp/1/message/template", requestOptions)
    .then((response) => response.text())
    .then((result) => console.log(result))
    .catch((error) => console.error(error));