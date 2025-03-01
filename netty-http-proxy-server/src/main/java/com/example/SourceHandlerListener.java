package com.example;

import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;

public class SourceHandlerListener implements ChannelFutureListener {

    ContentQueue contentQueue;
    SourceHandler sourceHandler;

    public SourceHandlerListener(ContentQueue contentQueue, SourceHandler sourceHandler) {
        this.contentQueue = contentQueue;
        this.sourceHandler = sourceHandler;
    }

    @Override
    public void operationComplete(ChannelFuture channelFuture) throws Exception {
        sourceHandler.setTargetChannel(channelFuture.channel());
        while (this.contentQueue.getSize() > 0) {
            Object byteBuffer = this.contentQueue.getContent();
            channelFuture.channel().writeAndFlush(byteBuffer);
//            ReferenceCountUtil.release(byteBuffer);
        }
    }
}
