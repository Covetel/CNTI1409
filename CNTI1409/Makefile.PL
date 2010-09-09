#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'CNTI1409';
all_from 'lib/CNTI1409.pm';

requires 'AutoLoader';
requires 'Catalyst::Runtime' => '5.8002';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Unicode::Encoding';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Breadcrumbs';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Controller::REST';
requires 'Catalyst::Controller::HTML::FormFu';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Authentication::Store::LDAP';
requires 'Catalyst::Plugin::Authorization::Roles';
requires 'Catalyst::Model::LDAP';
requires 'Catalyst::Model::LDAP::Connection';
requires 'Catalyst::Model::LDAP::Entry';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::TT';

requires 'DBIx::Class';
requires 'DBIx::Class::Core';
requires 'DBIx::Class::Schema';

# Nuestras librerias.
requires 'CNTI::Validator::CSS';
requires 'CNTI::ValidatorDB';
requires 'CNTI::Validator::Jobs';
requires 'CNTI::Validator::LibXML';
requires 'CNTI::Validator::Monitor::Event';
requires 'CNTI::Validator::Monitor::Job';
requires 'CNTI::Validator::Monitor::Result';
requires 'CNTI::Validator::Monitor::URL';
requires 'CNTI::Validator::Schema';
requires 'CNTI::Validator::Test';
requires 'CNTI::Validator::Tests';

requires 'Moose';
requires 'Moose::Role';
requires 'namespace::autoclean';
requires 'Config::General'; 
requires 'common::sense';
requires 'Config::Any::YAML';
requires 'Data::Dumper';
requires 'DateTime';
requires 'Digest::MD5';
requires 'Encode';
requires 'File::MMagic';
requires 'HTML::TreeBuilder';
requires 'JSON::XS';
requires 'lib';
requires 'POSIX';
requires 'Try::Tiny';
requires 'URI';
requires 'utf8';
requires 'WebService::Validator::CSS::W3C';
requires 'WebService::Validator::HTML::W3C';
requires 'WWW::Mechanize';
requires 'WWW::Mechanize::Cached';
requires 'XML::LibXML';

requires 'HTML::FormFu';
requires 'HTML::FormFu::Model::DBIC'; 
requires 'HTML::FormFu::Validator';
requires 'DBD::Pg';# Este módulo requiere del paquete de Debian libpq-dev, aptitude install libpq-dev
requires 'DateTime::Format::Pg';
requires 'Sub::Uplevel';
requires 'CSS::Tiny';
requires 'Template::Latex';
requires 'LaTeX::Encode';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
