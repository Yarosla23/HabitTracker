module HabitsHelper
  STATUS = ['Выполняется', 'Не выполняется', 'Выполнена']

  def nav_link_to(name, path)
    class_name = if current_page?(path)
                   'rounded-lg py-3 px-5 text-white block font-medium hover:text-blue-400 active:bg-blue-900 text-xl'
                 else
                   'rounded-lg py-3 px-5 text-gray-500 block font-medium hover:text-blue-400 active:bg-blue-900'
                 end
    link_to name, path, class: class_name
  end

  def status_svg_color(status)
    case status
    when 'Выполняется'
      'text-yellow-500'  
    when 'Не выполняется'
      'text-red-400'    
    when 'Выполнена'
      'text-green-500'   
    else
      'text-gray-500'   
    end
  end
end
