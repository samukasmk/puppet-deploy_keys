require 'spec_helper'

describe 'deploy_keys' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "deploy_keys class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('deploy_keys::params') }
        it { should contain_class('deploy_keys::install').that_comes_before('deploy_keys::config') }
        it { should contain_class('deploy_keys::config') }
        it { should contain_class('deploy_keys::service').that_subscribes_to('deploy_keys::config') }

        it { should contain_service('deploy_keys') }
        it { should contain_package('deploy_keys').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'deploy_keys class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('deploy_keys') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
