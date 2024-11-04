package com.example;

import io.netty.bootstrap.Bootstrap;
import io.netty.channel.*;
import io.netty.channel.socket.nio.NioSocketChannel;

import java.net.InetSocketAddress;

public class SourceHandler extends ChannelInboundHandlerAdapter {

    ContentQueue contentQueue;
    ChannelFuture connectFuture;
    Channel targetChannel;

    public SourceHandler(ContentQueue contentQueue) {
        this.contentQueue = contentQueue;
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        contentQueue.addContent(msg);
        if (connectFuture.isDone()) {
            targetChannel.writeAndFlush(msg);
//            ReferenceCountUtil.release(msg);
        }
    }

    @Override
    public void channelActive(ChannelHandlerContext ctx)
            throws Exception {
        Bootstrap bootstrap = new Bootstrap();
        bootstrap.channel(NioSocketChannel.class)
//                .option(NioChannelOption.of(StandardSocketOptions.SO_KEEPALIVE), true)
                .option(ChannelOption.SO_KEEPALIVE, true)
//                .option(EpollChannelOption.TCP_KEEPINTVL, 1000)
                .handler(new TargetHandler(this.contentQueue, ctx.channel()));
        bootstrap.group(ctx.channel().eventLoop());
        connectFuture = bootstrap.connect(new InetSocketAddress("localhost", 9091));
        connectFuture.addListener(new SourceHandlerListener(this.contentQueue, this));
    }

    public void setTargetChannel(Channel targetChannel) {
        this.targetChannel = targetChannel;
    }
}
