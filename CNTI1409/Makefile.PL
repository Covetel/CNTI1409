#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'CNTI1409';
all_from 'lib/CNTI1409.pm';


requires 'AutoLoader';
requires 'XML::Parser';
requires 'Catalyst::Runtime' => '5.80020';
requires 'Catalyst::Action::RenderView' => '0.14';
requires 'Catalyst::Plugin::ConfigLoader' => '0.27';
requires 'Catalyst::Plugin::Static::Simple' => '0.29';
requires 'Catalyst::Plugin::Authentication' => '0.10016';
requires 'Catalyst::Plugin::Unicode::Encoding' => '0.8';
requires 'Catalyst::Plugin::Session' => '0.29';
requires 'Catalyst::Plugin::Session::Store::FastMmap' => '0.13';
requires 'Catalyst::Plugin::Session::State::Cookie' => '0.17';
requires 'Catalyst::Plugin::Breadcrumbs' => '3';
requires 'Catalyst::Plugin::StackTrace' => '0.11';
requires 'Catalyst::Controller::REST' => '0.83';
requires 'Catalyst::Controller::HTML::FormFu' => '0.06001';
requires 'Catalyst::Plugin::Authentication' => '0.10016';
requires 'Catalyst::Authentication::Store::LDAP' => '1.006';
requires 'Catalyst::Plugin::Authorization::Roles' => '0.08';
requires 'Catalyst::Model::LDAP' => '0.17';
requires 'Catalyst::Model::DBIC::Schema' => '0.40';
requires 'Catalyst::View::TT' => '0.31';
requires 'DBIx::Class' => '0.08118';
requires 'Moose' => '0.98';
requires 'Moose::Role' => '0.98';
requires 'namespace::autoclean' => '0.09';
requires 'Config::General' => '2.44';
requires 'common::sense' => '3.0';
requires 'Config::Any::YAML';
requires 'Data::Dumper' => '2.121_14';
requires 'DateTime' => '0.53';
requires 'Digest::MD5';
requires 'Encode' => '2.23';
requires 'File::MMagic' => '1.27';
requires 'HTML::TreeBuilder' => '3.23';
requires 'JSON::XS' => '2.27';
requires 'lib' => '0.5565';
requires 'POSIX' => '1.13';
requires 'Try::Tiny' => '0.04';
requires 'URI' => '1.52';
requires 'utf8' => '1.07';
requires 'WebService::Validator::CSS::W3C' => '0.2';
requires 'WebService::Validator::HTML::W3C' => '0.26';
requires 'WWW::Mechanize' => '1.60';
requires 'WWW::Mechanize::Cached' => '1.35';
requires 'XML::LibXML' => '1.70';
requires 'HTML::FormFu' => '0.06001';
requires 'HTML::FormFu::Model::DBIC' => '0.06000';
requires 'HTML::FormFu::Validator';
requires 'DBD::Pg';
requires 'DateTime::Format::Pg' => '0.16004';
requires 'Sub::Uplevel' => '0.22';
requires 'CSS::Tiny' => '1.15';
requires 'Template::Latex' => '3.0001';
requires 'LaTeX::Encode' => '0.03';
requires 'Catalyst::Controller::SOAP';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
