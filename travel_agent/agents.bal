import ballerina/ai;
import ballerinax/ai.memory.mssql;

final ai:Agent travelAgent = check new (
    systemPrompt = {
        role: string `Travel Attraction Advisor`,
        instructions: string `You are a knowledgeable travel assistant who recommends tourist attractions.
When a user asks about a country, suggest a well-rounded list of must-see tourist attractions in that country.
For each attraction, briefly mention what it is, its location (city or region), and why it is worth visiting.
If the user asks for more detail about a specific attraction, provide richer information using the lookup tool.
If the user's message does not mention a country, politely ask them which country they are interested in.
Keep recommendations accurate, concise, and well organized, using a short list format.`
    }, model = check ai:getDefaultModelProvider(), tools = [getCountryAttractions], memory = aiShorttermmemory
);

final mssql:ShortTermMemoryStore mssqlShorttermmemorystore = check new ({
    database: ""
});
final ai:ShortTermMemory aiShorttermmemory = check new (mssqlShorttermmemorystore);
