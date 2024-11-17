module HabitsHelper
  def nav_link_to(name, path)
    class_name = if current_page?(path)
                   'rounded-lg py-3 px-5  text-white block font-medium hover:text-blue-400 active:bg-blue-900 text-xl'
                 else
                   'rounded-lg py-3 px-5 text-gray-500 block font-medium hover:text-blue-400 active:bg-blue-900 '
                 end
    link_to name, path, class: class_name
  end
end
