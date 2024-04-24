package com.team5.websocket;

import java.io.IOException;

import org.springframework.stereotype.Component;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;


@Component
@ServerEndpoint("/websocket")
public class MyWebSocket {
	
	@OnOpen
	public void onOpen(Session session) throws IOException {
		System.out.println("websocket已經連接"+session);
		//給客戶端響應,歡迎登入(連接)系統
		session.getBasicRemote().sendText("歡迎登錄系統");
	}
	
	@OnClose
	public void onClose(Session session) {
		System.out.println("websocket已經關閉:"+session);
	}
	
	@OnMessage
	public void onMessage(String message,Session session) throws IOException {
		System.out.println("收到客戶端發來的消息"+message);
		
		try {
			Thread.sleep(200);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//給客戶端一個反饋
		session.getBasicRemote().sendText("消息已收到");
	}
	
	
	
	
}
