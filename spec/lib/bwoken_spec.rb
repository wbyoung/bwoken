require 'bwoken'
require 'fileutils'

describe Bwoken do

  let(:proj_path) { File.expand_path('../../tmp/FakeProject', __FILE__) }
  before(:all) { FileUtils.mkdir_p(proj_path) }

  def stub_proj_path
    Dir.stub(:pwd => proj_path)
  end

  describe '.app_name' do
    it "returns the app's name without the .app prefix" do
      stub_proj_path
      Bwoken.app_name.should == 'FakeProject'
    end
  end

  describe '.app_dir' do
    it "returns the app's name with the .app suffix" do
      stub_proj_path
      Bwoken.app_dir.should == "#{proj_path}/build/FakeProject.app"
    end
  end

  describe '.project_path' do
    it 'returns the root directory of the project' do
      Dir.should_receive(:pwd).and_return(:foo)
      Bwoken.project_path.should == :foo
    end
  end

  describe '.path_to_automation' do
    it 'returns the location of the Automation template' do
      File.exists?(Bwoken.path_to_automation).should be_true
    end
  end

  describe '.build_path' do
    context "when it doesn't yet exist" do
      it 'creates the build directory' do
        stub_proj_path
        FileUtils.rm_r("#{proj_path}/build")
        Bwoken.build_path
        Dir.exists?("#{proj_path}/build").should be_true
      end
    end

    it 'returns the build directory' do
      stub_proj_path
      Bwoken.build_path.should == "#{proj_path}/build"
    end
  end

  describe '.workspace' do
    it 'returns the workspace directory' do
      stub_proj_path
      Bwoken.workspace.should == "#{proj_path}/FakeProject.xcworkspace"
    end
  end

  describe '.results_path' do
    context "when it doesn't yet exist" do
      it 'creates the results directory' do
        stub_proj_path
        FileUtils.rm_rf("#{proj_path}/automation")
        Bwoken.results_path
        Dir.exists?("#{proj_path}/automation/results").should be_true
      end
    end
    it 'returns the results path' do
      stub_proj_path
      Bwoken.results_path.should == "#{proj_path}/automation/results"
    end
  end

end