module QueueADT
  def self.empty_queue()
    []
  end

  def self.enqueue(queue, element)
    [element] + queue
  end

  def self.dequeue(queue)
    queue[0..-2]
  end

  def self.current(queue)
    queue[-1]
  end
end
