# frozen_string_literal: true

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

module Meetings
  class TableComponent < ::OpPrimer::BorderBoxTableComponent
    options :current_project # used to determine if displaying the projects column

    columns :title, :start_time, :project_name, :duration, :location

    mobile_columns :title, :start_time, :project_name

    mobile_labels :project_name

    main_column :title

    def sortable?
      true
    end

    def initial_sort
      %i[start_time asc]
    end

    def has_actions?
      true
    end

    def mobile_title
      I18n.t(:label_meeting_plural)
    end

    def headers
      @headers ||= [
        [:title, { caption: Meeting.human_attribute_name(:title) }],
        [:start_time, { caption: I18n.t(:label_meeting_date_and_time) }],
        current_project.blank? ? [:project_name, { caption: Meeting.human_attribute_name(:project) }] : nil,
        [:duration, { caption: Meeting.human_attribute_name(:duration) }],
        [:location, { caption: Meeting.human_attribute_name(:location) }]
      ].compact
    end

    def columns
      @columns ||= headers.map(&:first)
    end
  end
end
