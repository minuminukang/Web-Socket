package kr.or.iei.common;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

@Component("chatHandler")
public class ChatHandler extends TextWebSocketHandler {

	private ArrayList<WebSocketSession> members;
	private HashMap<String, WebSocketSession> map;
	
	public ChatHandler() {
		members = new ArrayList<WebSocketSession>();
		map = new HashMap<String, WebSocketSession>();
		System.out.println("소켓 생성됨!");
	}
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결 성공!!");
		members.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println(message.getPayload());
		
		JsonParser parser = new JsonParser();
		
		JsonElement element = parser.parse(message.getPayload());
		String type = element.getAsJsonObject().get("type").getAsString();
		
		if (type.equals("register")) {
			String memberId = element.getAsJsonObject().get("memberId").getAsString();
			map.put(memberId, session);
		} else if (type.equals("chat")) {
			String target = element.getAsJsonObject().get("target").getAsString();
			String msg = element.getAsJsonObject().get("msg").getAsString();
			String id = element.getAsJsonObject().get("id").getAsString();
			if(target == null || target.length() == 0) {
				for(String key : map.keySet()) {
					try {
						WebSocketSession ws = map.get(key);
						if(ws.isOpen() == false) {
							map.remove(key);
							continue;
						}
						if (ws != null) {
							ws.sendMessage(new TextMessage(id + " : "+msg));
						}
					} catch (Exception e) {
					}
				}
			}else {
				WebSocketSession ws = map.get(target);
				if (ws != null) {
					try {
						if(ws.isOpen() == false) {
							map.remove(target);
						}else {
							ws.sendMessage(new TextMessage(id + " : "+msg));
						}
					} catch (Exception e) {
					}
				}
			}
			
		} 
	}
	
	//연결이 끊겼을 때 동작하는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결 종료!!");
		members.remove(session);
	}
}
