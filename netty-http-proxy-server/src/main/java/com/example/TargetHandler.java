package com.example;

import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

public class TargetHandler extends ChannelInboundHandlerAdapter {

    ContentQueue contentQueue;
    Channel sourceChannel;

    public TargetHandler(ContentQueue contentQueue, Channel channel) {
        this.contentQueue = contentQueue;
        this.sourceChannel = channel;
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        sourceChannel.writeAndFlush(msg);
//        ReferenceCountUtil.release(msg);
    }
}
