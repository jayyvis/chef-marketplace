case node['platform_family']
when 'rhel', 'fedora'
  package 'php-mbstring' do
    action :install
  end
when 'debian'
  # debian php compiled with mbstring
end