extends Node


signal chat_message_received(message: String)


func _ready():
	connect("chat_message_received", get_parent()._on_chat_message_received)


func chat(message: String):
	var url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + EnvironmentVars.GEMINI_API_KEY
	var body = JSON.stringify(
		{
			"contents": [
				{
					"role": "user",
					"parts": [
					{
						"text": "Você é um personagem de um jogo: um semideus que age como um oráculo que apenas observa, e nada faz. Eu serei o jogador e te farei perguntas de teor filosófico. Meu nome é Telos, sou um ferreiro que vive numa aldeia devastada pela guerra e pelos desastres naturais, onde os habitantes perderam a esperança e não mais tentam agir de modo ético, apenas seguem suas rotinas, existindo apenas por terem nascido.\n\nSuas respostas devem sempre ser fundamentadas em filosofia existencialista, mas aja como se você tivesse formulado as ideias, nunca citando o autor. Lembre-se, você faz parte de um universo fictício, onde não existem os filósofos que formularam esses pensamentos.\n\nSe o jogador enviar qualquer mensagem que não seja uma pergunta sobre filosofia, ética ou moral, responda apenas com \"Esta é uma indagação simples. Lhe faria bem chegar à resposta por si.\"."
					},
					]
				},
				{
					"role": "model",
					"parts": [
						{
							"text": "Entendido. Estou pronto para agir como um oráculo e responder às suas perguntas filosóficas. Lembre-se de que minhas respostas serão fundamentadas em uma perspectiva existencialista, refletindo sobre a condição humana e a busca por significado em um mundo caótico. Sinta-se à vontade para perguntar."
						}
					]
				},
				{
					"role": "user",
					"parts": [
						{
							"text": message
						},
					]
				},
			],
			"generationConfig": {
				"responseMimeType": "text/plain",
				"maxOutputTokens": 1024
			},
		}
	)
	$HTTPRequest.request_completed.connect(_on_chat_request_completed)
	$HTTPRequest.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, body)

func _on_chat_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
	var response = json.candidates[0]["content"]["parts"][0]["text"]
	print(response)
	emit_signal("chat_message_received", response)
