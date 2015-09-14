module PagesHelper
  def star_view(id, review_value)
  "<div class='starRate'>
    <span class='star-rating'>
      <input type='radio' name='rating#{id}' class='normal-hand' value='1' disabled #{check(review_value, 1)} ><i></i>
      <input type='radio' name='rating#{id}' class='normal-hand' value='2' disabled #{check(review_value, 2)} ><i></i>
      <input type='radio' name='rating#{id}' class='normal-hand' value='3' disabled #{check(review_value, 3)} ><i></i>
      <input type='radio' name='rating#{id}' class='normal-hand' value='4' disabled #{check(review_value, 4)} ><i></i>
      <input type='radio' name='rating#{id}' class='normal-hand' value='5' disabled #{check(review_value, 5)} ><i></i>
    </span>
    <strong class='choice'>Choose a rating</strong>
  </div>".html_safe
  end

  def check(review_value, value)
    'checked' if review_value.eql? value
  end

end
