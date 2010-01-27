# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'ValidadorCNTI';
all_from 'lib/ValidadorCNTI.pm';

requires 'Catalyst::Runtime' => '5.7014';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

# Modulos adicionales
requires 'Catalyst::Plugin::Static::Simple';
requires 'WebService::Validator::HTML::W3C';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
