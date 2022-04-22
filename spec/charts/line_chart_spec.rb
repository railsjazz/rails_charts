require_relative "../rails_helper"

describe RailsCharts::LineChart do
  before do
    User.create(age: 10, role: 'admin', salary: 100, created_at: Date.yesterday)
    User.create(age: 11, role: 'admin', salary: 101, created_at: Date.today)
    User.create(age: 20, role: 'moderator', salary: 20, created_at: Date.yesterday)
    User.create(age: 21, role: 'moderator', salary: 21, created_at: Date.today)
    User.create(age: 22, role: 'moderator', salary: 22, created_at: Date.today)
  end

  describe "#line_chart 1 hash" do
    it "build_options" do
      data = {10 => 42, 20 => 4242}
      chart = RailsCharts::LineChart.new(data, {debug: true, options: { title: { text: "Hello" } }})
      expect(chart.build_options).to eq({
        :series=>[
          {:data=>[42, 4242], :type=>"line"}
        ],
        title: { text: "Hello" },
        :toolbox => {:feature=>{:saveAsImage=>{}}},
        :tooltip=>{:trigger=>"axis"},
        :xAxis=>{:data=>[10, 20], :type=>"category"},
        :yAxis=>{:type=>"value"}
      })
    end
  end

  describe '#line_chart 2 multi' do
    it 'works' do
      # [{:name=>"admin", :data=>{Thu, 21 Apr 2022=>1, Fri, 22 Apr 2022=>1}}, {:name=>"moderator", :data=>{Thu, 21 Apr 2022=>1, Fri, 22 Apr 2022=>2}}]
      data = User.distinct.pluck(:role).map{|e| {name: e, data: User.where(role: e).group_by_day(:created_at).count}}
      chart = RailsCharts::LineChart.new(data, { debug: false })
      expect(chart.build_options).to eq({
        :series=>[
          {:data=>[1, 1], :type=>"line", name: 'admin'},
          {:data=>[1, 2], :type=>"line", name: 'moderator'}
        ],
        :toolbox=>{:feature=>{:saveAsImage=>{}}},
        :tooltip=>{:trigger=>"axis"},
        :xAxis=>{
          :data=>[Date.yesterday, Date.current],
          :type=>"category"
        },
        :yAxis=>{:type=>"value"}
      })
    end
  end

end