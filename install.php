<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_navigatorproxysetting()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery("CREATE TABLE IF NOT EXISTS `navigatorproxysetting` (
                              `ID` INT(11) NOT NULL AUTO_INCREMENT,
                              `HARDWARE_ID` INT(11) NOT NULL,
                              `USER` VARCHAR(255) DEFAULT NULL,
                              `ENABLE` VARCHAR(255) DEFAULT NULL,
                              `ADDRESS` VARCHAR(255) DEFAULT NULL,
                              `AUTOCONFIGURL` VARCHAR(255) DEFAULT NULL,
                              `OVERRIDE` VARCHAR(255) DEFAULT NULL,
                              PRIMARY KEY  (`ID`,`HARDWARE_ID`)
                              ) ENGINE=INNODB;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_navigatorproxysetting()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE `navigatorproxysetting`");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_navigatorproxysetting()
{

}
