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

require "rsmart_toolbox/etl/grm"

class UnitHierarchy

  def initialize
    @unit_hash = {}
  end

  def load_row(unit_num, unit_name, unit_par)
    @unit_hash.store(unit_num, [unit_name, unit_par])
  end

  def is_valid?
    err_array = []
    if get_roots > 1
      err_array << ("More than 1 root node.")
    end
    # if get_duplicates > 0
    #   err_array << ("Duplicate units exist.")
    # end
    if get_depth('000001') > 4
      err_array << ("Hierarchy exceeds 4 levels")
    end
    if err_array.size > 0
      PP.pp(err_array)
    end
  end

  def get_roots
    roots = 0
    @unit_hash.each_key do |key|
      if key.eql? '000001'
        roots += 1
      end
    end
    return roots
  end

  def get_duplicates
    dups = 0
    @unit_hash.each_key do |key|
      if @unit_hash.find_all(key).size > 1
        dups += 1
      end
    end
    return dups
  end

  def get_depth(from)
    childarr = get_children from
    if get_children(from) == []
      return 1
    else
      depth = 0
      childarr.each do |child|
        depth = [depth, get_depth(child)].max
      end
    end
    return depth + 1
  end

  def get_name(unit_num)
    name = ""
    @unit_hash.each_pair do |key, value|
      if key.eql? unit_num
        name.concat value[0]
      end
    end
    return name
  end

  def get_par(unit_num)
    par = ""
    @unit_hash.each_pair do |key, value|
      if key.eql? unit_num
        par.concat value[1]
      end
    end
    return par
  end

  def get_children(unit_num)
    arr = []
    @unit_hash.each_pair do |key, value|
      if value.include? unit_num
        arr << key
      end
    end
    return arr
  end

end