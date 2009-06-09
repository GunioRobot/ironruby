require File.dirname(__FILE__) + '/../../spec_helper'

describe "Class#new" do
  it "returns a new instance of self" do
    klass = Class.new
    klass.new.is_a?(klass).should == true
  end
  
  it "invokes #initialize on the new instance with the given args" do
    klass = Class.new do
      def initialize(*args)
        @initialized = true
        @args = args
      end
      
      def args
        @args
      end
      
      def initialized?
        @initialized || false
      end
    end
    
    klass.new.initialized?.should == true
    klass.new(1, 2, 3).args.should == [1, 2, 3]
  end

  it "is private on classes" do
    klass = Class.new do
      def initialize
        1
      end
    end

    klass.should have_private_instance_method(:initialize)
  end

  it "can't be called on Class" do
    lambda { Class.send(:initialize) }.should raise_error(TypeError)
  end
end
