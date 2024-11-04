package com.example;

import io.netty.channel.ChannelFuture;

import java.net.InetSocketAddress;

/**
 * Hello world!
 *
 */
public class App {
    public static void main(String[] args) throws Exception {
        int port = Integer.parseInt("9090");
        final RPServer endpoint = new RPServer();

        ChannelFuture future = endpoint.start(new InetSocketAddress(port));
        Runtime.getRuntime().addShutdownHook(new Thread(endpoint::destroy));

        System.out.println("Server started on 9090 ...");
        future.channel().closeFuture().syncUninterruptibly();
    }
}
