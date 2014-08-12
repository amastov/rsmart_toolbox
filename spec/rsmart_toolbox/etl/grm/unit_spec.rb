# rSmart client library and command-line tool to help interact with rSmart's cloud APIs.
# Copyright (C) 2014 The rSmart Group, Inc.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'spec_helper'
require 'rsmart_toolbox/etl/grm/unit'

# UNIT = Rsmart::ETL::GRM::Unit

RSpec.describe "Rsmart::ETL::GRM::UNIT" do

  describe "#is_valid?" do
    it "should print exception if hierarchy exceeds 4 levels" do
      foo = UnitHierarchy.new
      csv = []
      csv << ['unit_number', 'unit_name', 'parent_unit_number']
      csv << ['000001', 'The Cool Kids Club', '-']
      csv << ['2', 'The Jedi Council', '000001']
      csv << ['3', 'Advanced Corn Popping Alliance', '2']
      csv << ['4', 'Salty Salt Salinizer Division' '3']
      csv << ['5', 'The rSmart Group', '4']
      csv.each do |row|
        foo.load_row(row[0], row[1], row[2])
      end
      expect(foo.is_valid?).to match_array(["Hierarchy exceeds 4 levels"])
    end
  end

end