<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Мой Простой AI Ассистент</title>
    
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .chat-container {
            width: 100%;
            max-width: 450px;
            height: 80vh;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            padding: 15px;
            background-color: #4a90e2; /* Синий цвет */
            color: white;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .chat-box {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            scroll-behavior: smooth;
        }

        /* Стили для сообщений */
        .message {
            margin-bottom: 15px;
            padding: 10px 15px;
            border-radius: 18px;
            max-width: 80%;
            line-height: 1.4;
        }

        .user-message {
            background-color: #e1ffc7; /* Светло-зеленый */
            margin-left: auto;
            border-bottom-right-radius: 4px;
            text-align: right;
        }

        .bot-message {
            background-color: #f0f0f0; /* Светло-серый */
            margin-right: auto;
            border-bottom-left-radius: 4px;
            text-align: left;
        }

        /* Форма ввода */
        .chat-input {
            display: flex;
            padding: 15px;
            border-top: 1px solid #eee;
        }

        .chat-input input {
            flex-grow: 1;
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-radius: 20px 0 0 20px;
            outline: none;
            font-size: 16px;
        }

        .chat-input button {
            padding: 10px 15px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 0 20px 20px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .chat-input button:hover {
            background-color: #3b7ad0;
        }
        
        /* Стили для окна результатов CSE (если оно отображается на этой же странице) */
        .search-results-container {
            /* Скрываем его по умолчанию или стилизуем, если вы хотите его показать */
            display: none; 
            padding: 20px;
            max-height: 100%;
            overflow-y: auto;
        }
        
    </style>
    
    <script async src="https://cse.google.com/cse.js?cx=875488c7a0a2a437f"></script>
</head>
<body>

    <div class="chat-container" id="chatContainer">
        <header class="chat-header">
            <h3>🤖 AI Ассистент (Поиск Google)</h3>
        </header>

        <div class="chat-box" id="chatBox">
            <div class="message bot-message">
                <p>Привет! Я использую поиск Google. Спроси меня о чем-нибудь.</p>
            </div>
        </div>

        <form id="chatForm" class="chat-input">
            <input type="text" id="userInput" placeholder="Введите ваш запрос для поиска..." required>
            <button type="submit">Искать</button>
        </form>
    </div>
    
    <div class="search-results-container" id="resultsContainer">
        <div class="gcse-searchresults-only"></div>
        <p style="text-align: center; margin-top: 20px;">
            <a href="#" onclick="showChat(); return false;">← Вернуться в чат</a>
        </p>
    </div>

    <script>
        const chatContainer = document.getElementById('chatContainer');
        const resultsContainer = document.getElementById('resultsContainer');

        document.getElementById('chatForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const userInputElement = document.getElementById('userInput');
            const userQuery = userInputElement.value.trim();

            if (userQuery === "") return;

            // 1. Отображаем сообщение пользователя
            addMessage(userQuery, 'user-message');
            userInputElement.value = ''; // Очищаем поле ввода
            
            // 2. Запускаем поиск через Google CSE
            executeSearch(userQuery);
        });

        function addMessage(text, type) {
            const chatBox = document.getElementById('chatBox');
            const messageDiv = document.createElement('div');
            messageDiv.classList.add('message', type);
            
            const p = document.createElement('p');
            p.innerHTML = text;
            messageDiv.appendChild(p);
            chatBox.appendChild(messageDiv);
            
            // Прокрутка вниз
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        // Функция для переключения на окно чата
        function showChat() {
            chatContainer.style.display = 'flex';
            resultsContainer.style.display = 'none';
        }

        // Функция для переключения на окно результатов
        function showResults() {
            chatContainer.style.display = 'none';
            resultsContainer.style.display = 'block';
        }
        
        // ⚠️ ГЛАВНАЯ ФУНКЦИЯ: Запуск поиска через Google CSE
        function executeSearch(query) {
            
            // Выводим сообщение о начале поиска
            addMessage(`Ищу **"${query}"** в Google.`, 'bot-message');
            
            // Имитация задержки перед показом результатов (как будто ИИ "думает")
            setTimeout(() => {
                
                // Программно выполняем поиск с помощью функции Google CSE
                // После этого результаты появятся в контейнере .gcse-searchresults-only
                google.search.cse.element.go(function() {
                    google.search.cse.element.getElement('searchresults').execute(query);
                });
                
                // Переключаем интерфейс, чтобы показать результаты
                showResults();
                
            }, 1000); // Задержка 1 секунда
        }
        
        // Инициализация: убедитесь, что при первой загрузке показано окно чата
        showChat(); 
    </script>
</body>
</html>
