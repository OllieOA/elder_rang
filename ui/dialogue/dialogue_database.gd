class_name DialogueDatabase extends Resource

enum Response {
	HAPPY, SAD
}

enum Type {
	RAMBLE,
	CORRECT,
	INCORRECT,
	GREETING,
	QUESTION
	}


const canned_replies = {
	Type.CORRECT: [
		"I knew you'd understand!",
		"Sometimes you're the only one who gets me.",
		"You're definitely your father's child!"
	],
	Type.INCORRECT: [
		"Your generation never listens to us!",
		"Did you even listen?",
		"Are you stupid? Do you understand me?",
		"I'm not mad, I'm just disappointed..."
	],
	Type.GREETING: [
		"Hello grandchild, lovely for you to finally want to talk to me! I am well, not that you asked...",
		"Ah, finally, you call me back! Good that you have the sense to listen to my wisdom...",
		"About time my grandchild decides to take their head out of their Nintendos or whatever!"
	],
	Type.QUESTION: [
		"Do you know what I mean?",
		"What do you think about that?",
		"How does it make you feel?",
	]
}


const dialogue_database = [
	{
		"difficulty": 1,
		"correct_response": Response.HAPPY,
		"content": "This is phrase 1 this is phrase 1 this is phrase 1 this is phrase 1 this is phrase 1 this is phrase 1 this is phrase 1. ",
		"used": false
	},
	{
		"difficulty": 1,
		"correct_response": Response.HAPPY,
		"content": "This is phrase 2 this is phrase 2 this is phrase 2 this is phrase 2 this is phrase 2 this is phrase 2 this is phrase 2.",
		"used": false
	},
	{
		"difficulty": 3,
		"correct_response": Response.HAPPY,
		"content": "This is phrase 3 this is phrase 3 this is phrase 3 this is phrase 3 this is phrase 3 this is phrase 3 this is phrase 3.",
		"used": false
	}
]
