# Encapsulate:
# 1. The core components in a Subject abstraction.
# 2. The variable components in an Observer hierarchy.

# Subject "pushing" what has changed to all Observers.
# Observer is responsible for "pulling" from the Subject.

# Subject should composite with list of observers.
# Observer should registered subjects in init phase.

# Observer could be the "View" part in MVC

class Observer
  # could be list of subjects
  def initialize(subject)
    @subject = subject
  end

  # as subscription method
  def update; end
end

class Subject
  def initialize
    @observers = []
    @state = nil
  end

  def add(observer)
    @observers.push observer
  end

  def get_state
    @state
  end

  # full-replacment approach
  # when state change, broadcast to all observers
  def set_state(new_state)
    @state = new_state
    execute
  end

  def execute
    @observers.each do |o|
      o.update
    end
  end
end

class InchObserver < Observer
  def initialize(subject)
    super(subject)
    @subject.add(self)
  end

  def update
    puts "#{@subject.get_state()} Metre is #{metre_conversion} inch"
  end

private

  def metre_conversion
    @subject.get_state() * 39.3701
  end
end

class CentiMetreObserver < Observer
  def initialize(subject)
    super(subject)
    @subject.add(self)
  end

  def update
    puts "#{@subject.get_state()} Metre is #{metre_conversion} cm"
  end

private

  def metre_conversion
    @subject.get_state() * 100
  end
end

metre_subject = Subject.new
io = InchObserver.new(metre_subject)
co = CentiMetreObserver.new(metre_subject)

puts "Subject change to 10 metre\n"
metre_subject.set_state(10)
puts "Subject change to 5 metre\n"
metre_subject.set_state(5)
