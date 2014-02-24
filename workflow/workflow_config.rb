require_relative 'bundle/bundler/setup'
require 'alfred'
require 'yaml'

class WorkflowConfig

  @resolutions

  @file

  def initialize
    @file = 'resolutions.yml'
    load_resolutions
  end

  def get_current_resolution
    current_resolution = {}
    `./setresx -ld`.chomp("\n")[12..-2].split(', ').each do |opt|
      opt = opt.split(/\s*=\s*/)
      current_resolution[opt[0]] =opt[1]
      current_resolution['width'] = current_resolution['resolution'].split('x')[0]
      current_resolution['height'] = current_resolution['resolution'].split('x')[1]
      current_resolution['dpi'] = current_resolution['scale'] == '2.0' ? 'HiDPI' : 'normal resolution'
    end
    current_resolution
  end

  def get_resolutions
    @resolutions
  end

  def get_resolution(id)
    @resolutions.detect do |resolution|
      resolution['id'] == id
    end
  end

  def remove_resolution(id)
    @resolutions.reject! do |resolution|
      true if resolution['id'] == id
    end

    # write config back
    write_config
  end


  def load_resolutions
    @resolutions = YAML.load(File.open @file) if File.exist? @file
    rebuild_resolutions if !@resolutions
  end

  def rebuild_resolutions
    # get full resolution list from cli app, and parse data into array of hashes
    @resolutions = `./setresx --modes`.chomp("\n").split("\n").map do |line|
      mode = {}
      line[7..-2].split(', ').each { |opt| opt = opt.split(/\s*=\s*/); mode[opt[0]] = opt[1] }
      mode['width'] = mode['resolution'].split('x')[0]
      mode['height'] = mode['resolution'].split('x')[1]
      mode['dpi'] = mode['scale'] == '2.0' ? 'HiDPI' : 'normal resolution'
      mode['id'] = "#{mode['resolution']}x#{mode['scale']}"
      mode
    end

    # removes normal resolutions that are available as HiDPI
    @resolutions.reject! do |mode|
      false if mode['scale'] == '2.0'
      true if mode['scale'] == '1.0' && @resolutions.any? { |m| m['id'] == "#{mode['width']}x#{mode['height']}x2.0" }
    end

    write_config
  end


  def write_config
    File.open(@file, 'w') { |f| f.write(@resolutions.to_yaml) }
  end

  private :load_resolutions, :write_config
end