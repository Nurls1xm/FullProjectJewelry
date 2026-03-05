const { GoogleGenerativeAI } = require('@google/generative-ai');

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

exports.sendMessage = async (req, res) => {
  try {
    const { message } = req.body;
    
    if (!message) {
      return res.status(400).json({ error: 'Message required' });
    }

    if (!process.env.GEMINI_API_KEY) {
      return res.status(500).json({ error: 'Gemini API key not configured' });
    }

    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    
    const systemPrompt = `Ты - вежливый помощник магазина украшений "Rai Diamond Store". 
Помогай клиентам с информацией о товарах, ценах и услугах.
Отвечай на казахском, русском или английском языке в зависимости от языка вопроса.
Будь дружелюбным и профессиональным.`;

    const result = await model.generateContent({
      contents: [
        {
          role: 'user',
          parts: [{ text: systemPrompt + '\n\nПользователь: ' + message }],
        },
      ],
    });

    const response = result.response.text();
    
    res.json({ 
      message: message,
      response: response,
      timestamp: new Date().toISOString()
    });
  } catch (err) {
    console.error('Gemini API error:', err);
    res.status(500).json({ error: 'Failed to process message' });
  }
};
