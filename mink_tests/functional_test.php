<?php

use PHPUnit\Framework\TestCase;


require_once 'vendor/autoload.php';




class BookfaceTest extends TestCase {

    function testHeader() {

        $driver = new \Behat\Mink\Driver\GoutteDriver();
        $session = new \Behat\Mink\Session($driver);
        $session->start();


        $session->visit("http://10.212.136.82/");
        $page = $session->getPage();

        $this->assertEquals(
            'bookface',
            $page->find('css', '.title')->getText(),
            'Title wasn\'t bookface.. should be'
        );
    }

    function testDB() {

        $driver = new \Behat\Mink\Driver\GoutteDriver();
        $session = new \Behat\Mink\Session($driver);
        $session->start();


        $session->visit("http://10.212.136.82/");
        $page = $session->getPage();

        $this->assertEquals(
            'Latest activity',
            $page->find('css', 'h2')->getText(),
            '"Latest activity" not found. DB down?'
        );
    }
}

