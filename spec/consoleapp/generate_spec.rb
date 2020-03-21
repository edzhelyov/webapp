require 'spec_helper'
require 'consoleapp/generate'

module Fibonacci
  describe Generate do
    [
      {n: 1, result: [
        [nil, 0],
        [0  , 0]
      ]},
      {n: 2, result: [
        [nil, 0, 1],
        [0  , 0, 0],
        [1  , 0, 1]
      ]},
      {n: 3, result: [
        [nil, 0, 1, 1],
        [0  , 0, 0, 0],
        [1  , 0, 1, 1],
        [1  , 0, 1, 1]
      ]},
      {n: 4, result: [
        [nil, 0, 1, 1, 2],
        [0  , 0, 0, 0, 0],
        [1  , 0, 1, 1, 2],
        [1  , 0, 1, 1, 2],
        [2  , 0, 2, 2, 4],
      ]},
    ].each do |test|
      it "generates #{test[:n]} matrix" do
        Generate.call(test[:n]).should eq [true, test[:result]]
      end
    end

    it 'accepts only positive numbers' do
      Generate.call(0).should eq [false, 'n must be a positive integer']
    end
  end
end
