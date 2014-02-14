require 'spec_helper'
require "vagrant-kvm/config"

describe  VagrantPlugins::ProviderKvm::Config do
  describe "#machine_type" do
    it "defaults to pc-1.2" do
      should_default(:machine_type, "pc-1.2")
    end
  end

  describe "#vnc_port" do
    it "defaults to -1" do
      should_default(:vnc_port, -1)
    end
  end

  describe "#vnc_password" do
    it "defaults to nil" do
      should_default(:vnc_password, nil)
    end
  end

  describe "#network_model" do
    it "defaults to 'virtio'" do
      should_default(:network_model, 'virtio')
    end
  end

  describe "#video_model" do
    it "defaults to 'virtio'" do
      should_default(:video_model, 'cirrus')
    end
  end

  describe "#image_mode" do
    it "sets image_backing to false if clone" do
      subject.image_mode = 'clone'
      subject.finalize!
      subject.image_backing.should be_false
    end

    it "sets image_backing to true if cow" do
      subject.image_mode = 'cow'
      subject.finalize!
      subject.image_backing.should be_true
    end
  end

  describe "#disk_bus" do
    it "defaults to nil" do
      should_default(:disk_bus, nil)
    end
  end

  private
  def should_default(field, default_value)
    instance = described_class.new
    instance.send(field).should == described_class::UNSET_VALUE
    instance.finalize!
    instance.send(field).should == default_value
  end
end
