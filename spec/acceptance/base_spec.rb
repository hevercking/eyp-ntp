require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'ntp class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'ntp':
        servers = [
                    '1.ie.pool.ntp.org',
                	   '0.europe.pool.ntp.org',
                	   '3.europe.pool.ntp.org'
                     ]
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)

      describe package('ntp') do
        it { is_expected.to be_installed }
      end

      describe service('ntp') do
        it { should be_enabled }
        it { is_expected.to be_running }
      end

      describe file('/etc/ntp.conf') do
        it { should be_file }
        its(:content) { should match 'puppet managed file' }
        its(:content) { should match 'server 1.ie.pool.ntp.org iburst' }
        its(:content) { should match 'server 0.europe.pool.ntp.org iburst' }
        its(:content) { should match 'server 3.europe.pool.ntp.org iburst' }
        its(:content) { should match 'driftfile /etc/ntp.drift' }
        its(:content) { should match 'restrict -4 default kod nomodify notrap nopeer noquery' }
        its(:content) { should match 'restrict -6 default kod nomodify notrap nopeer noquery' }
        its(:content) { should match 'restrict 127.0.0.1' }
        its(:content) { should match 'restrict ::1' }
      end

    end

  end
end
