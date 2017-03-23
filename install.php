<?php
function plugin_version_navigatorproxysetting()
{
return array('name' => 'navigatorproxysetting',
'version' => '1.1',
'author'=> 'Valentin DEVILLE',
'license' => 'GPLv2',
'verMinOcs' => '2.2');
}

function plugin_init_navigatorproxysetting()
{
$object = new plugins;
$object -> add_cd_entry("navigatorproxysetting","other");

$object -> sql_query("CREATE TABLE IF NOT EXISTS `navigatorproxysetting` (
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

function plugin_delete_navigatorproxysetting()
{
$object = new plugins;
$object -> del_cd_entry("navigatorproxysetting");
$object -> sql_query("DROP TABLE `navigatorproxysetting`");

}