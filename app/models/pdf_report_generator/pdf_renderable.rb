module PdfReportGenerator

class PDFRenderable

  def template_file
    raise "template filename, not implemented"
  end

  def create_new_page!(pdf)
    pdf.start_new_page(:template => open(template_file))
  end


  def render_to_page!(pdf_object, first_page = false)
   raise "not implemented"
  end





  def whole_number_part(f = 0.00)
    int = ("%.2f" % f).to_s.split('.')[0].reverse
    
    while int.gsub!(/(,|\.|^)(\d{3})(\d)/, '\1\2,\3')
    end

    int.reverse

  end
  

  def fraction_number_part(f = 0.00)
    ("%.2f" % f).to_s.split('.')[1]
  end

  def money_format(f = 0.00)
    "#{whole_number_part(f)}.#{fraction_number_part(f)}"
  end


  def text_box(pdf, left, top, value, options = {})

    size = options[:size] || 8
    width = options[:width] || 200
    height = options[:height] || 10
    overflow = options[:overflow] || :truncate
    align = options[:align] || :left

    if value && pdf
      pdf.text_box value, :at => [left, pdf.cursor - top], :size => size, :width => width, :height => height, :overflow => :overflow, :align => align
    end
  end


  def sheet_money_box(pdf, left, top, value)

    if value && pdf 

      pdf.text_box whole_number_part(value), :at => [left, pdf.cursor - top], :size => 6, :width => 36, :height => 10, :overflow => :truncate, :align => :right #, :borders => [:top, :left, :bottom, :right], :border_width => 3, :border_color => "FF0000"

      pdf.text_box fraction_number_part(value), :at => [left + 43, pdf.cursor - top], :size => 6, :width => 8, :height => 10, :overflow => :truncate, :align => :right

    end

  end




  def money_box(pdf, left, top, value, options = {})

    size = options[:size] || 8
    width = options[:width] || 50
    height = options[:height] || 10
    overflow = options[:overflow] || :truncate
    align = options[:align] || :right

    if value && pdf
      pdf.text_box money_format(value), :at => [left, pdf.cursor - top], :size => size, :width => width, :height => height, :overflow => :overflow, :align => align
    end

  end




end


end
