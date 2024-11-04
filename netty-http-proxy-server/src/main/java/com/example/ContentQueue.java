package com.example;

import java.util.LinkedList;

public class ContentQueue {
    LinkedList<Object> content = new LinkedList<Object>();

    public void addContent(Object byteBuffer) {
        content.add(byteBuffer);
    }

    public Object getContent() {
        return content.poll();
    }

    public int getSize() {
        return this.content.size();
    }
}
