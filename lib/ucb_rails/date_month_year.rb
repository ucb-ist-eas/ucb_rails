module UcbRails::DateMonthYear
  extend ActiveSupport::Concern

  module ClassMethods
    # Defines a getter and setter for each (Date) attribute that handles
    # dates in MM/DD/YYYY format
    #
    #   class Foo < ActiveRecord::Base
    #
    #     # defines project_begin_mmddyyyy=(), project_begin_mmddyyyy()
    #     date_mmddyyyy :project_begin
    #
    #     # date_mmddyyyy validator
    #     validates :project_begin_mmddyyyy, date_mmddyyyy: {allow_blank: true}
    #
    #   end
    #
    #   foo = Foo.new(project_begin_mmddyyyy: '1/2/2003')
    #   foo.project_begin_mmddyyyy  #=> "01/02/2003"
    #   foo.project_begin           #=> Thu, 02 Jan 2003
    #
    def date_mmddyyyy(*attributes)
      attributes.each do |attribute|

        define_method "#{attribute}_mmddyyyy" do
          v = self[attribute]
          v.present? ? v.strftime("%m/%d/%Y") : instance_variable_get("@#{attribute}_mmddyyyy")
        end

        define_method "#{attribute}_mmddyyyy=" do |v|
          value = if v =~ %r[(\d{1,2})/(\d{1,2})/(\d{4})]
            mm, dd, yyyy = $1.to_i, $2.to_i, $3.to_i
            begin
              Date.new(yyyy, mm, dd)
            rescue ArgumentError
              ''
            end
          else
            ''
          end

          self[attribute] = value
          instance_variable_set("@#{attribute}_mmddyyyy", v)
        end

      end
    end

    # Defines a getter and setter for each (Date) attribute that only considers
    # the month and year.
    #
    #   class Foo < ActiveRecord::Base
    #
    #     # defines start_date_mmyyyy=(), start_date_mmyyyy()
    #     date_mmyyyy :start_date
    #
    #     # date_mm_yyyy validator
    #     validates :start_date_mmyyyy, date_mm_yyyy: {allow_blank: true}
    #
    #   end
    #
    #   foo = Foo.new(start_date_mmyyyy: '12/2001')
    #   foo.start_date_mmyyyy  #=> '12/2001'
    #   foo.start_date        #=> Fri, 01 Dec 2000
    #
    def date_mmyyyy(*attributes)
      attributes.each do |attribute|

        define_method "#{attribute}_mmyyyy" do
          v = self[attribute]
          v.present? ? v.strftime("%m/%Y") : instance_variable_get("@#{attribute}_mmyyyy")
        end

        define_method "#{attribute}_mmyyyy=" do |v|
          value = if v =~ %r{^\d{1,2}/\d{4}$}
            month, year = v.split('/')
            Date.new(year.to_i, month.to_i)
          else
            ''
          end

          self[attribute] = value
          instance_variable_set("@#{attribute}_mmyyyy", v)
        end

      end
    end

    # Defines a getter and setter for each (Date) attribute that only considers
    # the year.
    #
    #   class Foo < ActiveRecord::Base
    #
    #     # defines graduation_date_yyyy=(), graduation_date_yyyy()
    #     date_yyyy :graduation_date
    #
    #     # date_yyyy validator
    #     validates :graduation_date_yyyy, date_yyyy: {allow_blank: true}
    #
    #   end
    #
    #   foo = Foo.new(graduation_date_yyyy: '2000')
    #   foo.graduation_date_yyyy   #=> '2000'
    #   foo.graduation_date        #=> Sat, 01 Jan 2000
    #
    def date_yyyy(*attributes)
      attributes.each do |attribute|

        define_method "#{attribute}_yyyy" do
          v = self[attribute]
          v.present? ? v.strftime("%Y") : instance_variable_get("@#{attribute}_yyyy")
        end

        define_method "#{attribute}_yyyy=" do |v|
          value = if v =~ /^\d{4}$/
            Date.new(v.to_i)
          else
            ''
          end

          self[attribute] = value
          instance_variable_set("@#{attribute}_yyyy", v)
        end

      end
    end
  end
end
