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
		"You're definitely your father's child!",
		"Thank you being there for me. Nobody does anymore.",
		"Listening is a virtue that I never expected from you!",
		"Ever since you were a child, I've been waiting for you to say something like that!"
	],
	Type.INCORRECT: [
		"Your generation never listens to us!",
		"Did you even listen? Do you ever listen?",
		"Are you stupid? Do you understand me?",
		"I'm not mad, I'm just disappointed...",
		"You better not be making those magic fake ape coins or whatever!",
		"I may as well be dead to you! You're not getting anything in the will"
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
		"How would you react?",
		"Do you a agree?",
		"Right? Right?",
		"Susie thinks so, you know Susie? What do you think?"
	]
}


const dialogue_database = [
	{
		"correct_response": Response.HAPPY,
		"content": "So, how are you today? There's so much I've been planning to discuss with you, like you know what happened at the pond today. I was feeding the birds and an old woman walked by. She had such a kind face, a nice smile and such pretty blond hair. You know me and old ladies. I do try to be nice to everyone I meet.",
		"used": false
	},
	{
		"correct_response": Response.SAD,
		"content": "My neighbour, you know Rob? He has those petunias in the front yard? Anyway, he painted his mailbox sky gray, which just infuriates me! I'm going to report him because he knows, HE KNOWS, that we have to paint our letterboxes brushed metal gray! But he just does whatever he wants, and I'm not going to let him get away with it this time.",
		"used": false
	},
	{
		"correct_response": Response.SAD,
		"content": "You know how old ladies tell everything to each other, and I mean everything? Today Beth trusted me to tell the whole story. Her previous husband was helpless romantic and would write poetry to her. One day, when he was on a business trip in Arizona, he sent a bouquet of flowers to her, as well as a letter that read: 'You are the love of my life. I cannot live without.'",
		"used": false
	},
	{
		"correct_response": Response.SAD,
		"content": "I check the obituaries every day, you know. Names and faces I haven't seen in years keep appearing in them. What was the point of it all? Sure, I lead a nice life, but what did I accomplish? Is this all there really was to have, to experience?",
		"used": false
	},
	{
		"correct_response": Response.HAPPY,
		"content": "I went to the park today. It was a chilly afternoon, and there were awful children around. Eventually, after lunch, they left me alone and I was able to feed the ducks. This gave me the peace I needed, and I felt happy. I felt content.",
		"used": false
	},
	{
		"correct_response": Response.SAD,
		"content": " I remember when you used to go to the store with two shillings and a sixpence and you'd come back with groceries for the week! And the service was friendly, smiles everywhere, and they always had time for a chat. But you don't get service like that these days, do you?",
		"used": false
	},
	{
		"correct_response": Response.SAD,
		"content": "Oh, you did what? What a bad accident! You know, back in the day, accidents had real consequences. My husband and I, well, we had an accident, and if it wasn't for that, you wouldn't even be here! Consequences, they don't necessarily need to be bad, but I think in this case we could certainly agree that they were.",
		"used": false
	},
	{
		"correct_response": Response.HAPPY,
		"content": "You know how it is these days... back in my day things were a lot better. We didn't have these fangled machines that did everything for us. I miss the days, but I am glad to have lived them.",
		"used": false
	},
	{
		"correct_response": Response.SAD,
		"content": "A month ago, I saw your cousin Lynda, you know how Lynda is she never stops talking. Once you get her going, she won’t stop. I was out for a walk at the time because I decided to go try out that newfangled bird park. Do you know how much money they spent on that park?",
		"used": false
	},
	{
		"correct_response": Response.HAPPY,
		"content": "I got a letter today. Does anyone even send letters anymore? The smell of the pen, and the feel of the paper, it's always so good. It's sad that people don't send more letter, though getting one definitely made me feel good. There was nothing important in the letter, mind you. Something about having an onion on one's belt...",
		"used": false
	},
	{
		"correct_response": Response.HAPPY,
		"content": "Did I tell you what happened last time I went to the newsagents? I decided that luck was on my side that day, so I decided to buy a scratch ticket. I never felt my heart race as fast as it did when I scratched off those three bananas.",
		"used": false
	},
	{
		"correct_response": Response.HAPPY,
		"content": "A new family moved in next door; they have a very large dog. All it does is bark and bark and bark. I went out in my backyard yesterday and threw some of my super special meatloaf over the back fence. I haven’t heard a peep out of it since.",
		"used": false
	},
	{
		"correct_response": Response.SAD,
		"content": "Back in my day you could smoke on a plane, and no one would care. I went for a trip down to Florida last month and now they want me to wear a mask?",
		"used": false
	},
	{
		"correct_response": Response.HAPPY,
		"content": "Barbara and I played Bridge today. She is awful at bridge. I truly despise Barbara and everything she stands for. She is a complete waste of my time. The look on her face filled me with such joy when I put down the final card. I'll never forget it.",
		"used": false
	},
	
]
