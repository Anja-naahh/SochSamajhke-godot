extends Node

var quizzes = {
	"upi": [
		{"question": "What is needed to send money using UPI?",
		 "options": ["Only Aadhaar card", "Bank account linked to mobile and a UPI PIN"],
		 "answer": 1},
		{"question": "What is the safest way to pay a shopkeeper using UPI?",
		 "options": ["Let them type UPI ID", "Scan shop QR code yourself"],
		 "answer": 1},
		{"question": "When should you enter your UPI PIN?",
		 "options": [ "Only while sending money","Always"],
		 "answer": 0}
	],
	"scam": [
		{"question": "KYC incomplete. Click: phonepesupport-k8.in",
		 "options": ["Click to update", "Check URL first"],
		 "answer": 1},
		{"question": "Electricity bill due on 15th.",
		 "options": [ "Verify and pay officially","Ignore"],
		 "answer": 0},
		{"question": "You’ve won ₹10,000! clickmoneywin.in",
		 "options": ["Click to win", "Ignore,check scam"],
		 "answer": 1}
	],
	"cardloan": [
		{"question": "Want ₹30,000 phone, only ₹5k in hand",
		 "options": ["Use credit card", "Take a loan", "Use debit card"],
		 "answer": 1},
		{"question": "Groceries ₹700, you have enough balance",
		 "options": ["Use debit card", "Credit card", "Take loan"],
		 "answer": 0},
		{"question": "Bike repair ₹8000, repay in a month",
		 "options": ["Credit card", "Debit card", "Take loan"],
		 "answer": 0}
	],
	"final": [
		{"question": "Where can you report fraud?",
		 "options": ["Cybercrime Portal", "Your College"],
		 "answer": 0},
		{"question": "Aadhaar seeding benefit?",
		 "options": ["Get subsidies to account", "Get foreign jobs"],
		 "answer": 0},
		{"question": "What should you check in loan app?",
		 "options": ["Google reviews", "If RBI-registered"],
		 "answer": 1}
	]
}
